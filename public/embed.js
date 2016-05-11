var Contribute = (function(window, undefined){

  var Contribute = {};

  Contribute.styles = {
    contributeCommentBody: [
      'color: red;',
      'background-color: blue;'
    ],
  };

  Contribute.templates = [
    {
      name: 'appViewTemplate',
      html:
      '<div id="contribute-header">' +
        '<div id="contribute-logo">' +
          'contribute.' +
        '</div>' +
        '<div id="contribute-profile-container">' +
        '</div>' +
      '</div>' +
      '<div class="contribute-major-divider"></div>' +
      '<div id="contribute-compose-container">' +
      '</div>' +
      '<div id="contribute-review-container" hidden>' +
      '</div>' +
      '<div id="contribute-comments-container">' +
      '</div>'
    },
    {
      name: 'profileViewTemplate',
      html:
      '<div>' +
        '<input type="submit" value="Sign Out" id="contribute-sign-out-button" class="contribute-button">' +
      '</div>'
    },
    {
      name: 'composeViewTemplate',
      html:
      '<div>' +
        '<div contenteditable="true" placeholder="Contribute to the conversation..." id="contribute-comment-field"></div>' +
        '<button id="contribute-submit-button" type="submit" class="contribute-button">Submit Comment</button>' +
      '</div>'
    },
    {
      name: 'commentsViewTemplate',
      html:
      '<div>' +
      '</div>'
    },
    {
      name: 'commentViewTemplate',
      html:
      '<div class="contribute-minor-divider"></div>' +
      '<span class="contribute-comment-meta"><span class="contribute-strong-red">{{= contributor.username }}</span><span> | {{ if (created_at_readable) }}{{= created_at_readable }}</span></span>' +
      '<span><img src="http://localhost:3000/chat.svg"></span>' +
      '<div class="contribute-comment-body">' +
        '{{= body_text }}' +
      '</div>'
    },
    {
      name: 'signInTemplate',
      html:
      '<form>' +
          '<input placeholder="Username or Email" type="text" id="contribute-username-email-field" class="contribute-input-field" required>' +
          '<input placeholder="Password" type="password" id="contribute-password-field" class="contribute-input-field" required>' +
          '<input type="submit" value="Sign In" id="contribute-sign-in-button" class="contribute-button contribute-button-large">' +
      '</form>'

    },
    {
      name: 'reviewViewTemplate',
      html:
      '<div id="contribute-review-header">Contribute Community Moderation.</div>' +
      '<div id="contribute-review-flex">' +
        '<div id="contribute-review-body">' +
          '{{= body_text }}' +
        '</div>' +
        '<div id="contribute-review-options">' +
          '<div id="contribute-review-intro">Please check that this comment meets the Contribute community standards.</div>' +
          '<div id="contribute-review-standards">From what you can tell, does the comment contain any of the following?</div>' +
          '<form id="contribute-review-form">' +
              '<label id="contribute-label">Advertising or Spam  </label><input name="contribute-review" type="radio" value="spam"></br>' +
              '<label id="contribute-label">Racial Vilification  </label><input name="contribute-review" type="radio" value="error1"></br>' +
              '<label id="contribute-label">Sexual Harassment  </label><input name="contribute-review" type="radio" value="error2"></br>' +
              '<label id="contribute-label">Unreasonable Personal Attacks  </label><input name="contribute-review" type="radio" value="error3"></br>' +
              '<label id="contribute-label">Encouragement of Violence  </label><input name="contribute-review" type="radio" value="error4"></br>' +
              '<label id="contribute-label">No, it Contains None of the Above </label><input name="contribute-review" type="radio" value="okay"></br>' +
            '<button type="submit" id="contribute-submit-review-button" class="contribute-button contribute-button-large">Submit Review & Post Your Comment</button>' +
          '</form>' +
        '</div>' +
      '</div>'

    }
  ];

  var loadSupportingFiles = function(callback) {
    loadScript('http://localhost:3000/jquery.js', function() {
      loadScript('http://localhost:3000/underscore+backbone.js', callback);
    });
  };

  var loadScript = function(url, callback) {
    var script = document.createElement('script');
    script.async = true;
    script.src = url;

    var entry = document.getElementsByTagName('script')[0];
    entry.parentNode.insertBefore(script, entry);

    // Using both .onload and .readystatechange so compatible with IE 8 and earlier
    script.onload = script.onreadystatechange = function() {
      var rdyState = script.readyState;
      if (!rdyState || /complete|loaded/.test(script.readyState)) {
          callback();
          script.onload = null;
          script.onreadystatechange = null;
      }
    };
  };

  loadSupportingFiles(function() {
    loadScript('http://localhost:3000/contribute.js', function() {
        var div = document.createElement('div');
        Contribute.$(div).attr('id', 'contribute-main');
        var appendTo = document.getElementById('contribute-embed');
        appendTo.parentNode.insertBefore(div, appendTo);

        // Load in templates for Backbone
        _.each(Contribute.templates, function(template) {
          var script = document.createElement('script');
          Contribute.$(script).attr('id', template.name);
          Contribute.$(script).attr('type', 'text/template');
          script.innerHTML = template.html;

          appendTo.parentNode.insertBefore(script, appendTo);
        });

        Contribute.app = Contribute.app || {};

        _.templateSettings = {
         interpolate: /\{\{\=(.+?)\}\}/g,
         evaluate: /\{\{(.+?)\}\}/g
        };

        Contribute.app.comment = new Contribute.app.Comment();
        Contribute.app.contributor = new Contribute.app.Contributor();
        Contribute.app.session = new Contribute.app.Session();
        Contribute.app.review = new Contribute.app.Review();
        Contribute.app.comments = new Contribute.app.Comments();
        Contribute.app.appView = new Contribute.app.AppView();
        Contribute.app.profileView = new Contribute.app.ProfileView({ model: Contribute.app.contributor });
        Contribute.app.reviewView = new Contribute.app.ReviewView({model: Contribute.app.review });
        Contribute.app.commentsView = new Contribute.app.CommentsView();
        Contribute.app.composeView = new Contribute.app.ComposeView();
        Contribute.Backbone.history.start();

    });
  });

  return Contribute;
})(window);
