const CalendarSingleton = (function){
		let calendar Instance;

		function createCalendar() {
			const calendar = $('#calendar').fullcalendar({

				header: {
					left : 'prev,next today',
					center: 'title',
					right: 'agendaDay,agendaWeek,month'
				},

				buttonText :{
					today: 'Today',
					month: 'Month',
					week: 'Week Agenda',
					day: 'Day Agenda',
					list: 'List',
					prevYear: 'Previous Year',
					nextYear: 'Next Year',
					prev: 'Previous',
					next: 'Next'
				},

				footer: {
					right: 'prevYear,nextYear'
				},

				themeSystem: 'jquery-ui',
				aspectRatio: 2,
				selectable: true,


				select : function(start,end) {
					handleSelect(start,end);
					$('#dialog').dialog();
				},


				eventClick : function(calendarEvent,browserEvent,view){
					handleEventClick(calendarEvent, browserEvent, view);
				},


				eventDrop: function(event,delta,revertFunc) {
					if(!confirm("Are you sure about  this change?")) {
						revertFunc();
					} else {
						handleEventDrop(event);
					}
				}
			});

			return calendar;
		}

		return {
			getCalendar : function() {
				if(!calendarIstance) {
					calendarIstance = createCalendar();
				}
				return calendarIstance;
			},
		}
})();


const addEvents = function(eventsData) {

		const events = [];
		eventsData.forEach(function(event) {
			const newEvent = {};

			newEvent.Id = event.Event__c;
			newEvent.title = event.Event__r.Name;
			newEvent.start = new Date(event.Event__r.Start_Time__c).toISOString();
			newEvent.end = new Date(event.Event__r.End_Time__c).toISOString();
			newEvent.editable = true;
			events.push(newEvent);
		});

		if(events.length > 0) {
			$('#calendar').fullcalendar('removeEventSources'); 
			$('#calendar').fullcalendar('addEventSource',events); 
		}
	}


	const handleEventClick = function(calendarEvent, browserEvent, view) {
		$('#updateEvent').css("display","block");
		$('#updateEventTitle').val(calendarEvent.title);
		$('#updateStartTime').val(calendarEvent.start);
		$('#updateEndTime').val(calendarEvent.end);
		$('#recordId').val(calendarEvent.Id);
		$('#dialog').dialog("close");
	}

	const handleSelect = function(start,end) {
		$('#createEventTitle').val("");
		$('#createStartTime').val(start);
		$('#createEndTime').val(end);
	}

	const prepareEvent = function(title,startTime,endTime,Id) {
		const calendarEvent = {};
		calendarEvent.Id = Id;
		calendarEvent.Name = title;
		calendarEvent.Start_Time__c = new Date(startTime).getTime();
		calendarEvent.End_Time__c = new Date(endTime).getTime();
		createOrUpdateEvents(JSON.stringify(calendarEvent));
	}

	const handleEventDrop = function(event) {
		const calendarEvent = {};
		calendarEvent.Id = event.Id;
		calendarEvent.Name = event.title;
		calendarEvent.Start_Time__c = new Date(event.start).getTime();
		calendarEvent.End_Time__c = new Date(event.end).getTime();
		createOrUpdateEvents(JSON.stringify(calendarEvent));
	}

	const attachListners = function() {
		$('#newEventForm').submit(function(event){

			const title = $('#createEventTitle').val();
			const startTime = $('#createStartTime').val();
			const endTime = $('#createEndTime').val();

			if(new Date(startTime).getTime() > new Date(endTime).getTime()) {
				$('#createStartTime').after('<span style="color:red"><br> Start time must be before End time </span>');
			}
			prepareEvent(title,startTime,endTime);
			$("#dialog").dialog("close");
			event.preventDefault();
		});

		$('#updateEventForm').submit(function(event) {
			const title = $('#updateEventTitle').val();
			const startTime = $('#updateStartTime').val();
			const endTime = $('#updateEndTime').val();
			const Id = $('#recordId').val();

			if(new Date(startTime).getTime() > new Date(endTime).getTime()) {
				$('#updateStartTime').after('<span style="color:red"><br>Start time must be before End time</span>');
			}
			prepareEvent(title,startTime,endTime,Id);
			event.preventDefault();
		});
	}