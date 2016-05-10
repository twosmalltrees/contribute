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
      '<div id="profile-container">' +
      '</div>' +
      '<div id="compose-container">' +
      '</div>' +
      '<div id="review-container">' +
      '</div>' +
      '<div id="comments-container">' +
      '</div>'
    },
    {
      name: 'profileViewTemplate',
      html:
      '<div>' +
        '<img src="http://www.fillmurray.com/100/100">' +
        '<button type="submit" id="contribute-sign-out-button">Sign Out</button>' +
      '</div>'
    },
    {
      name: 'composeViewTemplate',
      html:
      '<div>' +
        '<input id="contribute-comment-field">' +
        '<button id="contribute-submit-button" type="submit">Submit</button>' +
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
      '<div class="contribute-comment-body" style="' + Contribute.styles.contributeCommentBody.join('') + '">' +
        '{{= body_text }}' +
      '</div>'
    },
    {
      name: 'signInTemplate',
      html:
      '<form>' +
          '<label>Username or Email</label><input type="text" id="contribute-username-email-field">' +
          '<label>Password</label><input type="password" id="contribute-password-field">' +
          '<button type="submit" id="contribute-sign-in-button">Sign In</button>' +
      '</form>'
    },
    {
      name: 'reviewViewTemplate',
      html:
      '<div id="contribute-review-body">' +
      '{{= body_text }}' +
      '</div>' +
      '<div id="contribute-review-options">' +
        '<form id="contribute-review-form">' +
          '<input type="radio" name="reviewOutcome" value="racism"> Racist' +
          '<input type="radio" name="reviewOutcome" value="sexism"> Sexist' +
          '<input type="radio" name="reviewOutcome" value="acceptable"> Acceptable' +
          '<button type="submit">Submit Review</button>' +
        '</form>' +
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
