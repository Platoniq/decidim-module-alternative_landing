$(() => {
  const target = document.getElementById("participatory-process-group-homepage-calendar");
  let filters = JSON.parse(decodeURIComponent(target.dataset.resources));

  function removeFilter(filters, filter){
    return filters.filter((element) => element !== filter)
  }

  const events = JSON.parse(decodeURIComponent(target.dataset.events)).map((event, index) => ({
    id: index + 1,
    ...event
  }));

  const calendarEl = document.getElementById('calendar');
  const calendar = new Calendar(calendarEl, {
    plugins: [timeGridPlugin, dayGridPlugin],
    locale: "es",
    height: "auto",
    eventTimeFormat: {
      hour: "2-digit",
      minute: "2-digit",
      hour12: false,
      omitZeroMinute: false
    },
    events: events
  });

  $(function() {
    calendar.setOption('locale', target.dataset.locale);
    calendar.render();
    const initialEvents = calendar.getEvents()
    $(".cal-filter").on("click", function() {
      $(this).toggleClass("hollow");
      let filter = $(this).attr("id");
      if (filters.includes(filter)) {
        filters = removeFilter(filters, filter)
      } else {
        filters.push(filter)
      }
      filterEvents(initialEvents);
    });
  });

  function getCurrentEventsIds() {
    return calendar.getEvents().map(event => event.id);
  }

  function filterEvents(initialEvents) {
    const currentEventsIds = getCurrentEventsIds();
    const currentEvents = calendar.getEvents();
    
    initialEvents.forEach(event => {
      if (filters.includes(event._def.extendedProps.resourceId) && !currentEventsIds.includes(event.id)) {
        calendar.addEvent(event);
      }
    });

    const eventsToRemove = currentEvents.filter(event => 
      !filters.includes(event._def.extendedProps.resourceId)
    ).map(event => event.id);
  
    eventsToRemove.forEach(eventId => {
      const event = calendar.getEventById(eventId);
      if (event) {
        event.remove();
      }
    });
  }
});
