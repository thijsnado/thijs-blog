class @PostPreviewer
  @showPreviewFor: (fields) ->
    previewer = new this(fields)
    previewer.previewHtml()

  constructor: (fields) ->
    @text = fields.text
    @preview = fields.preview
    @url = fields.url

  previewHtml: ->
    text = $(@text).val()
    $.ajax
      url: @url
      data: { text: text }
      dataType: 'text'
      type: 'post'
      success: (data) =>
        $(@preview).html(data)

