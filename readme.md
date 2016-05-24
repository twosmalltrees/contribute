contribute.
===========

## What is it?

Contribute is the community moderated commenting platform. The goal is to reduce the voice of trolls, and otherwise abusive jerks in our online communities. It depends upon a system of community moderation - ie: when posting a comment, a user may be requested to perform a quick review of another users comment, and state that it is okay to be posted online. Comments from new or untrusted users will be subjected to a number of these reviews by random members of the community before being approved to appear in the comments thread.

Check out a live demo of the app [here](http://twosmalltrees.github.io/contribute-demo/).

#### Anonymous...but not too anonymous

If desired, contributors are able to sign up using only a username and password. As no personal information is attached to the account, this maintains a level of anonymity. However, each account has a reputation score attached. This score is what determines the posting privileges of a user. New users will be assigned a neutral score, and until they have built up a trusted reputation by making multiple approved posts, their comments will always be directed through the community moderation system.

## Sign up

To use Contribute on your website, you'll first need to [sign up with a host account](https://contribute-app.herokuapp.com/host_users/sign_in).

If you'd like to comment on a discussion, you'll need to [sign up as a contributor](https://contribute-app.herokuapp.com/sign_in).

## Set up

To add a Contribute discussion to your page, you'll firstly need to register the domain that you'd like to add the discussion thread to. This can be done through your host account.

Once registered, just copy and paste the following code snippet at the location you'd like the comment thread to appear:

    <script id="contribute-embed">
      (function(){
        var script = document.createElement('script');
        script.src = 'https://contribute-app.herokuapp.com/embed.js'
        script.async = true;
        var entry = document.getElementsByTagName('script')[0];
        entry.parentNode.insertBefore(script, entry);
      })();
    </script>

A new comment thread will be generated for each unique URL that makes a request for a comments thread from a registered domain.

## Technologies

* Underscore.js
* Backbone.js
* jQuery
* Ruby on Rails
* Fontawesome
* Bootstrap
* Rack Cors
