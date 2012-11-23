class @InfiniteScroll
  constructor: (options = {}) ->
    @paginationMarker = options.paginationMarker || $('.pagination')
    @innerPaginationContainer = options.innerPaginationContainer || $(window)
    @outerPaginationContainer = options.outerPaginationContainer || $(document)
    @url = options.url || '/'
    @processing = false

  setObserver: ->
    @innerPaginationContainer.scroll(@checkScroll.bind(this))

  checkScroll: ->
    if @innerPaginationContainer.scrollTop() > @outerPaginationContainer.height() - @innerPaginationContainer.height() - 50 && !@processing
      @processing = true
      @sendRequest()

  sendRequest: ->
    $.ajax
      url: @url
      type: 'get'
      dataType: 'text'

      success: (data) =>
        response = $.parseJSON(data)
        @processing = false
        $(response.html).insertBefore(@paginationMarker)
        @url = response.url



