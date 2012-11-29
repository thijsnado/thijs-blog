testResponses =
  success:
    status: 200
    responseText: "{\"html\":\"<p class='derp'>derp</p>\", \"url\": \"hello\"}"
  lastPage:
    status: 200
    responseText: "{\"html\":\"<p class='derp'>derp</p>\", \"url\": \"hello\", \"lastPage\": true}"

describe "InfiniteScroll", ->
  infiniteScroller = null
  paginationMarker = null
  innerPaginationContainer = null
  outerPaginationContainer = null

  beforeEach ->
    loadFixtures('infinite_scroll.html')
    paginationMarker = $('.pagination')
    innerPaginationContainer = $(window)
    outerPaginationContainer = $(document)
    infiniteScroller = new InfiniteScroll
      paginationMarker: paginationMarker
      innerPaginationContainer: innerPaginationContainer
      outerPaginationContainer: outerPaginationContainer
      url: 'derp'

  describe "setObserver", ->
    xit "puts a scroll callback that calls checkScroll on the inner container", ->
      spyOn(innerPaginationContainer, 'scroll')
      infiniteScroller.setObserver()
      expect(innerPaginationContainer.scroll).toHaveBeenCalledWith(infiniteScroller.checkScroll.bind(infiniteScroller))

  describe "checkScroll", ->
    it "does not call sendRequest if conditions are not met", ->
      spyOn(innerPaginationContainer, 'scrollTop').andReturn(100)
      spyOn(innerPaginationContainer, 'height').andReturn(100)
      spyOn(outerPaginationContainer, 'height').andReturn(1000)
      spyOn(infiniteScroller, 'sendRequest')
      infiniteScroller.checkScroll()
      expect(infiniteScroller.sendRequest).not.toHaveBeenCalled()

    it "calls sendRequest if conditions are met", ->
      spyOn(innerPaginationContainer, 'scrollTop').andReturn(100)
      spyOn(innerPaginationContainer, 'height').andReturn(100)
      spyOn(outerPaginationContainer, 'height').andReturn(100)
      spyOn(infiniteScroller, 'sendRequest')
      infiniteScroller.checkScroll()
      expect(infiniteScroller.sendRequest).toHaveBeenCalled()

  describe "sendRequest", ->
    it "sends a get request to url", ->
      spyOn($, 'ajax')

      infiniteScroller.sendRequest()

      expect($.ajax).toHaveBeenCalledWith
        url: 'derp'
        type: 'get'
        dataType: 'text'
        success: jasmine.any(Function)

    it "inserts response before pagination marker", ->
      jasmine.Ajax.useMock()

      infiniteScroller.sendRequest()

      request = mostRecentAjaxRequest()
      request.response(testResponses.success)

      expect($('.derp').length).toEqual(1)

    it "goes to url provided by json request next time", ->
      jasmine.Ajax.useMock()

      infiniteScroller.sendRequest()

      request = mostRecentAjaxRequest()
      request.response(testResponses.success)

      spyOn($, 'ajax')

      infiniteScroller.sendRequest()

      expect($.ajax).toHaveBeenCalledWith
        url: 'hello'
        type: 'get'
        dataType: 'text'
        success: jasmine.any(Function)

   it "turns of listener and hides spinner if last_page is set to true", ->
     spyOn(innerPaginationContainer, 'unbind')
     jasmine.Ajax.useMock()

     infiniteScroller.sendRequest()

     request = mostRecentAjaxRequest()
     request.response(testResponses.lastPage)

     expect(paginationMarker).not.toBeVisible()
     expect(innerPaginationContainer.unbind).toHaveBeenCalledWith('scroll.infinite_scroll')


