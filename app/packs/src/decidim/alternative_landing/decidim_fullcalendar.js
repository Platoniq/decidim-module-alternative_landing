document.addEventListener("DOMContentLoaded", () => {
  const target = document.getElementById("participatory-process-group-homepage-calendar");
  let filters = JSON.parse(decodeURIComponent(target.dataset.resources));

  const removeFilter = (filterArray, filter) => {
    return filterArray.filter((element) => element !== filter);
  };

  const events = JSON.parse(decodeURIComponent(target.dataset.events)).map((event, index) => ({
    id: index + 1,
    ...event
  }));

  const calendarEl = document.getElementById("calendar");
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

  const getCurrentEventsIds = () => {
    return calendar.getEvents().map((event) => event.id);
  };

  const filterEvents = (initialEvents) => {
    const currentEventsIds = getCurrentEventsIds();
    const currentEvents = calendar.getEvents();
    
    initialEvents.forEach((event) => {
      if (filters.includes(event._def.extendedProps.resourceId) && !currentEventsIds.includes(event.id)) {
        calendar.addEvent(event);
      }
    });

    const eventsToRemove = currentEvents.filter((event) => 
      !filters.includes(event._def.extendedProps.resourceId)
    ).map((event) => event.id);
  
    eventsToRemove.forEach((eventId) => {
      const event = calendar.getEventById(eventId);
      if (event) {
        event.remove();
      }
    });
  };
  
  const initializeCalendar = () => {
    calendar.setOption("locale", target.dataset.locale);
    calendar.render();
    const initialEvents = calendar.getEvents();

    document.querySelectorAll(".cal-filter").forEach((filterButton) => {
      filterButton.addEventListener("click", function() {
        this.classList.toggle("hollow");
        let filter = this.id;
        if (filters.includes(filter)) {
          filters = removeFilter(filters, filter);
        } else {
          filters.push(filter);
        }
        filterEvents(initialEvents);
      });
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initializeCalendar);
  } else {
    initializeCalendar();
  }
});
