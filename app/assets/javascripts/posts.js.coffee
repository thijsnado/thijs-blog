class PostPreviewer
  @showPreviewFor: (options) ->
    new this(options)

  constructor: (options) ->
    console.log options
    @form = options.form
    @preview = options.preview

$(document).ready ->
  PostPreviewer.showPreviewFor(form: 'form', preview: '.preview')
