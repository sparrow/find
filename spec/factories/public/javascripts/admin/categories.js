$(function() {
  $('.edit_category').editable(function(value,settings) {
    startLoading();
    $.post('/admin/categories/rename', {id: $(this).attr('data-id'), value: value}, function(result) {
      stopLoading();
      if (result!='') {
        $.jGrowl(result);
      }
    });
    return value;
  },{
    type: 'text',
    id: 'data-id',
    width: 300
  });

  $('a.delete_category').click(function() {
    var tr = $(this).closest('tr');
    var table = tr.closest('table');

    if (confirm('Really delete this category?')) {
      startLoading();
      $.ajaxDelete($(this).attr('href'), function() {
        stopLoading();
        tr.fadeOut(function() {
          tr.remove();
          table.find('tr').removeClass('bg');
          table.find('tr:even').addClass('bg');
        });
      });
    };
    return false;
  });
});
