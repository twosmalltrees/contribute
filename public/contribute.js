Contribute.app = Contribute.app || {};

Contribute.app.AppRouter = Contribute.Backbone.Router.extend({

});

Contribute.app.Session = Contribute.Backbone.Model.extend({
  urlRoot: 'http://localhost:3000/sign_in',

  requestAuth: function(username_or_email, password) {
    // jQuery namespaced to avoid possible conflicts with 3rd party sites.
    Contribute.$.ajax({
      url: 'http://localhost:3000/remote_sign_in',
      type: 'POST',
      data: {
        username_or_email: username_or_email,
        password: password,
      },
      xhrFields: {
         withCredentials: true
      }
    }).done(function() {
      Contribute.app.contributor.getCurrentContributor();
    });
  },

  destroySession: function() {
    Contribute.$.ajax({
      url: 'http://localhost:3000/remote_sign_in',
      type: 'POST',
      dataType: "json",
      data: {"_method":"delete"},
      xhrFields: {
         withCredentials: true
      }
    }).done(
      Contribute.app.contributor.clearCurrentContributor
    );
  }
});

Contribute.app.Contributor = Contribute.Backbone.Model.extend({

  urlRoot: 'http://localhost:3000/remote_current_contributor',

  defaults: {
    is_signed_in: false
  },

  initialize: function() {
    this.getCurrentContributor();
  },
  // To test if session is persisting logged in user...
  getCurrentContributor: function() {
    var that = this;
    Contribute.$.ajax({
      url: 'http://localhost:3000/remote_current_contributor',
      type: 'GET',
      xhrFields: {
         withCredentials: true
      }
    }).done(function(response) {
        that.set(response);
        if (response !== null) {
          that.set('is_signed_in', true);
        }
       });
  },

  clearCurrentContributor: function() {
    Contribute.app.contributor.clear();
  }
});

Contribute.app.Review = Contribute.Backbone.Model.extend({
  urlRoot: 'http://localhost:3000/reviews',

  initialize: function() {
    this.on("change", function() {
      console.log("Review model change function called");
      Contribute.app.reviewView.render();
    });
  },

  defaults: {
    review_in_progress: false,
    comment_id: null,
    body_text: null,
    review_result: null
  },

  submitReview: function() {
    console.log("review submitted");
    // Submit the review
    // Need to find some way of verifying authenticity of submitted reviews...
    Contribute.$.ajax({
      url: 'http://localhost:3000/submit_review',
      type: 'POST',
      data: {
        comment_id: this.comment_id,
        review_result: this.review_result,
      },
      xhrFields: {
         withCredentials: true
      }
    }).done(function() {
      // When review sucessfully submitted, then submit the contributors comment.
      console.log("was this succssessful?");
      // Reset review to defaults
      Contribute.app.review.set({
          review_in_progress: false,
          comment_id: null,
          body_text: null,
          review_result: null
        });
      // Submit the comment
      Contribute.app.composeView.submitComment();
    }).fail(function() {
      // What if review submission fails?
      console.log("review submit...ahhh failed");
    });
  }


});

Contribute.app.Comment = Contribute.Backbone.Model.extend({
  urlRoot: 'http://localhost:3000/comments',
  defaults: {
    body_text: null
  }
});

Contribute.app.Comments = Contribute.Backbone.Collection.extend({
  url: 'http://localhost:3000/comments',

  model: Contribute.app.Comment,

  initialize: function() {

    this.fetch().done();

    this.on('sync', function() {
      Contribute.app.commentsView.render();
    });

  },
});


Contribute.app.AppView = Contribute.Backbone.View.extend({

  el: '#contribute-main',

  initialize: function() {
    this.render();
  },

  render: function() {
    var appViewTemplate = Contribute.$('#appViewTemplate').html();
    this.$el.html(appViewTemplate);
  }

});



Contribute.app.CommentView = Contribute.Backbone.View.extend({

  tagName: 'div',

  render: function() {
    var template = _.template( Contribute.$('#commentViewTemplate').html() );
    this.$el.html(template( this.model.toJSON() ) );
    return this;
  }

});



Contribute.app.CommentsView = Contribute.Backbone.View.extend({
  el: '#comments-container',

  render: function() {
    this.addAllComments();
  },

  addOneComment: function(comment) {
    comment = new Contribute.app.CommentView({ model: comment });
    this.$el.prepend(comment.render().el);
  },

  addAllComments: function() {
    this.$el.html('');
    Contribute.app.comments.each(function(comment) {
      this.addOneComment(comment);
    }, this);
  }

});

Contribute.app.ComposeView = Contribute.Backbone.View.extend({
  el: '#compose-container',

  events: {
    "click #contribute-submit-button" : "requestSubmitPermission"
  },

  initialize: function() {
    this.render();
  },

  render: function() {
    this.$el.html('');
    var template = Contribute.$('#composeViewTemplate').html();
    this.$el.append(template);
  },

  // Queries Contribute to check there is a current user session on the server side, and also
  // requests moderation of a community comment if required.
  requestSubmitPermission: function() {
    Contribute.$.ajax({
      url: 'http://localhost:3000/request_submit_permission',
      type: 'GET',
      xhrFields: {
         withCredentials: true
      }
    }).done(function(response) {
      if (response.review_required === true && response.contributor_signed_in === true) {
        // If commununity moderation contribution required, create new Review view.
        console.log("Congratulations, you have been selected to conduct a review!");
        Contribute.app.review.set({
          review_in_progress: true,
          comment_id: response.comment_id,
          body_text: response.comment_body
        });

      } else if (response.review_required === false && response.contributor_signed_in === true) {
        // If no community moderation contribution required, will submit the comment.
        Contribute.app.composeView.submitComment();
      } else {
        // No contributor currently signed in.
      }
    });
  },

  submitComment: function() {
    // Actually send off comment submission request.
    var bodyText = Contribute.$('#contribute-comment-field').val();
    var newComment = new Contribute.app.Comment({
      body_text: bodyText
    });
    console.log("made a new comment to submit");
    Contribute.$.ajax({
      url: 'http://localhost:3000/comments',
      type: 'POST',
      data: newComment.attributes,
      xhrFields: {
         withCredentials: true
      }
    }).done(function() {
      Contribute.app.commentsView.addOneComment(newComment);
    }).fail(function() {

    });
  },


});

Contribute.app.ReviewView = Contribute.Backbone.View.extend({

  el: '#review-container',

  events: {
    "click #contribute-submit-review-button" : "submitButtonPress"
  },

  initialize: function() {
    this.render();
  },

  render: function() {
    this.$el.html('');
    var template = _.template( Contribute.$("#reviewViewTemplate").html() );
    this.$el.html( template( this.model.toJSON() ) );
    this.toggleVisibility();
  },

  toggleVisibility: function() {
    if (this.model.get("review_in_progress") === false) {
      this.$el.hide();
    } else {
      this.$el.toggle(400);
    }
  },

  submitButtonPress: function(event) {
    event.preventDefault();
    if (Contribute.$('#contribute-review-outcome-select').val() === null) {
      // Some action to prompt the user to select an option
      console.log("You haven't entered any input");
    } else {
      // Otherwise call submitReview
      this.model.set( 'review_result', Contribute.$('#contribute-review-outcome-select').val() );
      this.model.submitReview();
    }
  }

});


Contribute.app.ProfileView = Contribute.Backbone.View.extend({

  el: '#profile-container',

  events: {
    "click #contribute-sign-in-button" : "requestSignIn",
    "click #contribute-sign-out-button" : "requestSignOut"
  },

  initialize: function() {

    this.render();

    this.model.on('change', function() {
      console.log("was called");
      this.render();
    }, this);

  },

  render: function() {

    this.$el.html('');
    // var template = Contribute.$('#profileViewTemplate').html();
    // this.$el.append(template);

    if (this.model.get('is_signed_in') === true) {
      console.log("this was called");
      // Render the signed in users profile
      var currentUserTemplate = _.template(Contribute.$('#profileViewTemplate').html() );
      this.$el.html(currentUserTemplate( this.model.toJSON() ));
    } else {
      // Display sign_in_prompt/form
      var signInTemplate = Contribute.$('#signInTemplate').html();
      this.$el.html(signInTemplate);
    }

  },

  requestSignIn: function(event) {
    event.preventDefault();
    var username_or_email = Contribute.$('#contribute-username-email-field').val();
    var password = Contribute.$('#contribute-password-field').val();
    Contribute.app.session.requestAuth(username_or_email, password);
  },

  requestSignOut: function(event) {
    event.preventDefault();
    Contribute.app.session.destroySession();
  }

});
