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
    console.log "echo"
    # success = (response) ->
    #   console.log "test"
    #   console.log response
    #   $(@preview).html(response)
    #   console.log $(@preview).html()
    $.ajax
      url: @url
      data: { text: text }
      dataType: 'text'
      success: (data) =>
        console.log data
        $(@preview).html(data)
        console.log $(@preview).html()

# $(document).ready ->
#   PostPreviewer.showPreviewFor(form: 'form', preview: '.preview')
