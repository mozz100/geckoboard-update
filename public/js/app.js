// see http://diveintohtml5.info/storage.html
function supports_html5_storage() {
  try {
    return 'localStorage' in window && window['localStorage'] !== null;
  } catch (e) {
    return false;
  }
}

$(function() {

  input_selector = ':input[type!="hidden"][type!="submit"]';

  // intercept form submit and do by AJAX instead
  $('form').submit(function(e) {
    frm = $(this);
    frm.find('input:submit').attr({disabled: true, value: 'Updating...'});
    $('#feedback').fadeOut('fast');
    $.ajax({
      context: frm,
      complete: function() {
        // reset ui to normal
        $(this).find('input:submit').attr({disabled: null, value: 'Update'});

        // save the value into localstorage
        if (supports_html5_storage()) {
          $(this).find(input_selector).each(function(i, input) {
            localStorage.setItem(input.id, $(input).val());
          });
        }
      },
      data: frm.serialize(),
      error: function(jqXHR, textStatus, errorThrown) {
        alert('An error occurred.\n' + errorThrown);
      },
      success: function(data) {
        $('#feedback').hide().removeClass();
        $('#feedback').text(data);
        $('#feedback').addClass('alert alert-success').fadeIn();
      },
      type: 'POST',
      url: '/push'
    });
    e.preventDefault();
  });

  if (supports_html5_storage()) {
    // retrieve the values that this user last used for the geckoboard.
    $('form').each(function(i, frm) {
      //alert(frm.id);
      $(frm).find(input_selector).each(function(i, input) {
        $(input).val(localStorage.getItem(input.id));
      });
    });
  }
})

