jQuery(function($) {
  var edit_url = $('.page-head').attr('data-edit-url');
  var show_url = $('.page-head').attr('data-show-url');

  function unhideOther($editable) {
    if ($editable.attr('data-also-hide')) {
      $($editable.attr('data-also-hide')).removeClass('hidden');
    }
  }

  function bindForm($editable) {
    $editable.find('form').ajaxForm({
      beforeSubmit: startLoading,
      success: function(html) {
        stopLoading();
        $editable.html(html);
        var $form = $editable.find('form');
        if ($form.size() > 0) {
          bindForm($editable);
        } else {
          $editable.removeClass('active');
          unhideOther($editable);
        }
      }
    });

    $editable.find('form a.cancel').click(function(event) {
      $editable.html($editable.attr('data-original-html'));
      $editable.removeClass('active');
      unhideOther($editable);
      event.preventDefault();
    });

    // for locations
    if ($editable.find('#city').size() > 0) {
      $editable.find('#city').completeCities({
        afterResult: function(data) {
          $editable.find("#location_id").val(data[0]);
        }
      });
    }

    function deleteContact(event) {
      var $contact = $(this).closest('fieldset');
      $contact.addClass('hidden');
      $contact.find('input._destroy').attr('value','1');
      event.preventDefault();
    }

    function changeContactType() {
      if ($(this).attr('value')=='ContactService') {
        $(this).closest('fieldset').find('input.edit_name').removeClass('hidden').attr('value', 'Other service');
        $(this).addClass('hidden');
      }
    }

    // for contact services
    if ($editable.find('#edit-contacts').size() > 0) {
      $editable.find('a.delete_contact').click(deleteContact);
      $editable.find('select.edit_type').change(changeContactType);
      $editable.find('.add_contact').click(function(event) {
        var $contact = $(this).closest('form').find('fieldset.new-contact').clone().removeClass('new-contact').removeClass('hidden');
        $(this).closest('form').find('.fieldsets').append($contact);
        $contact.find('a.delete_contact').click(deleteContact);
        $contact.find('select.edit_type').change(changeContactType);
        event.preventDefault();
      });
    }
  }

  $('.editable .edit').live('click', function(event) {
    //load edit form
    var $editable = $(this).closest('.editable');
    $editable.attr('data-original-html',$editable.html());
    var edit_field_url = edit_url+'?field='+$editable.attr('data-field');
    var show_field_url = show_url+'?field='+$editable.attr('data-field');
    if ($(this).hasClass('in-popup')) {
      $(this).attr('href', edit_field_url);
      popup.show(this);
    } else {
      startLoading();
      $editable.load(edit_field_url, function() {
        stopLoading();
        if ($editable.attr('data-also-hide')) {
          $($editable.attr('data-also-hide')).addClass('hidden');
        }
        $editable.addClass('active');
        bindForm($editable);
      });
    }
    event.preventDefault();
  });

});
