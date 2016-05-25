jQuery(function ($) {
  'use strict';

  $('.js-ev-presence').on('click', 'button[value=yes]', markUserAsPresent);
  $('.js-ev-presence').on('click', 'button[value=no]', markUserAsAbsent);

  function markUserAsPresent() {
    var $el = $(this);
    if ($el.is('.btn-info')) { return; }
    performAjaxRequest($el, { presence: 1 });
  }

  function markUserAsAbsent() {
    var $el = $(this);
    if ($el.is('.btn-danger')) { return; }
    performAjaxRequest($el, { presence: 0 });
  }

  function performAjaxRequest(button, data) {
    $.ajax({
      url:      registrationUpdateURL(button),
      method:   'POST',
      data:     jQuery.extend(forgeryProtectedFormParams('PUT'), data),
      dataType: 'json',
      context:  button
    }).then(preparePresenceUpdateResponseProcessor(button));
  }

  function registrationUpdateURL(button) {
    var registrationId = button.parents('tr:eq(0)').data('id');
    return $('#event-registrations-list').data('url-base').replace(':id', registrationId);
  }

  function preparePresenceUpdateResponseProcessor(clickedElement) {
    return function (data) {
      if (data.status !== 'success') { return; }

      var presentCounter = $('#ev-present');
      var increment      = data.result === 'present' ? 1 : -1;

      presentCounter.text(+presentCounter.text() + increment);

      if (data.result === 'present') {
        hightlightYesButtonAsClicked(clickedElement);
      } else {
        hightlightNoButtonAsClicked(clickedElement);
      }
    };
  }

  function hightlightYesButtonAsClicked(yesButton) {
    yesButton.addClass('btn-info').removeClass('btn-default').
      next().addClass('btn-default').removeClass('btn-danger');
  }

  function hightlightNoButtonAsClicked(noButton) {
    noButton.addClass('btn-danger').removeClass('btn-default').
      prev().addClass('btn-default').removeClass('btn-info');
  }
});
