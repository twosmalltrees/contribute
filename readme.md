contribute.
===========

## What is it?

Contribute is the community moderated commenting platform. The goal is to reduce the voice of trolls, and otherwise abusive jerks in our online communities.

#### Anonymous...but not too anonymous

If desired, contributors are able to sign up using only a username and password. As no personal information is attached to the account, this maintains a level of anonymity. However, each account has a reputation score attached.

#### Reputation

Each user gets a 

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

If placed in a layout file, a new comment thread will be generated for each unique URL generated that uses the layout.

## Technologies
