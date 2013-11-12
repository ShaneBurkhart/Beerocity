$('.card_form').ready(function() {
  $("form input[type=submit]").click(function() {
      $("input[type=submit]", $(this).parents("form")).removeAttr("clicked");
      $(this).attr("clicked", "true");
  });
  $.externalScript('https://js.stripe.com/v1/').done(function(script, textStatus) {
      Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
      var subscription = {
        setupForm: function() {
          return $('.card_form').submit(function() {
            var val = $("input[type=submit][clicked=true]").val();
            console.log(val);
            if(val == "Back")
              return true;
            $('input[type=submit]').prop('disabled', true);
            if ($('#card_number').length) {
              subscription.processCard();
              return false;
            } else {
              return true;
            }
          });
        },
        processCard: function() {
          var card;
          card = {
            name: $('#user_name').val(),
            number: $('#card_number').val(),
            cvc: $('#card_code').val(),
            expMonth: $('#card_month').val(),
            expYear: $('#card_year').val()
          };
          return Stripe.createToken(card, subscription.handleStripeResponse);
        },
        handleStripeResponse: function(status, response) {
          if (status === 200) {
            $('#order_stripe_token').val(response.id)
            $('.card_form')[0].submit()
          } else {
            $('#stripe_error').text(response.error.message).show();
            return $('input[type=submit]').prop('disabled', false);
          }
        }
      };
      return subscription.setupForm();
  });
});
