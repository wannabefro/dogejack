Ember.Handlebars.helper('format-error', function(errors) {
  var html = '';
  if (errors) {
    html += errors.join(', ')
  }
  return html.htmlSafe();
})
