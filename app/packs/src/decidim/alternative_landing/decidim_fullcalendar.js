$(() => {
  const target = document.getElementById("participatory-process-group-homepage-calendar");
  let filters = JSON.parse(target.dataset.resources.replaceAll('&quote;', '"'));

  function removeFilter(filters, filter){
    return filters.filter((element) => element !== filter)
  }

  const calendarEl = document.getElementById('calendar');
  const calendar = new Calendar(calendarEl, {
    plugins: [timeGridPlugin, dayGridPlugin],
    defaultView: "dayGridMonth",
    locale: "es",
    header: {
      left: "prev,next today",
      center: "title",
      right: "dayGridMonth,dayGridWeek,dayGridDay"
    },
    height: "auto",
    eventTimeFormat: {
      hour: "2-digit",
      minute: "2-digit",
      hour12: false,
      omitZeroMinute: false
    },
    events: JSON.parse(target.dataset.events.replaceAll('&quote;', '"')),
    eventRender: function(info) {
      if ("subtitle" in info.event.extendedProps) {
        title = "<span class=\"fc-title\"><b>" + info.event.title + "</b> - " + info.event.extendedProps.subtitle + "</span>"
        info.el.firstChild.innerHTML = title
      }
      return filters.includes(info.event.extendedProps.resourceId);
    }
  });
  $(function() {
    calendar.setOption('locale', target.dataset.locale);
    calendar.render();
    $(".cal-filter").on("click", function() {
      $(this).toggleClass("hollow");
      let filter = $(this).attr("id");
      if (filters.includes(filter)) {
        filters = removeFilter(filters, filter)
      } else {
        filters.push(filter)
      }
      calendar.rerenderEvents()
    });
  });
});
