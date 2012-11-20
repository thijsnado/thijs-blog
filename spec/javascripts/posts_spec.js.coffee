testResponses =
  success:
    status: 200
    responseText: "<p>derp</p>"

describe "PostPreviewer", ->
  beforeEach ->
    loadFixtures('previewer.html')

  describe "showPreviewFor", ->
    showPreviewFor = ->
      fields =
        text: '#text'
        preview: '#preview'
        url: 'derp'
      PostPreviewer.showPreviewFor(fields)

    it "should send to url the data in text field passed", ->
      spyOn($, 'ajax')
      showPreviewFor()
      expect($.ajax).toHaveBeenCalledWith
        url: 'derp'
        data: { text: 'derp' }
        dataType: 'text'
        success: jasmine.any(Function)

    it "should send data from text option to url option, then display in preview option", ->
      jasmine.Ajax.useMock()

      showPreviewFor()

      request = mostRecentAjaxRequest()
      request.response(testResponses.success)

      expect($('#preview')).toHaveHtml('<p>derp</p>')

