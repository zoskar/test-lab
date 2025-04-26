function getEventIdByName(eventName) {
  const eventsUrl = 'https://test-lab-a4a12-default-rtdb.europe-west1.firebasedatabase.app/events.json';
  var response = http.get(eventsUrl);

  if (response.status !== 200) {
    throw new Error(`Failed to fetch events: ${response.status}`);
  }

  var eventsData = JSON.parse(response.body);

  if (!eventsData) {
    return null;
  }
  for (var eventId in eventsData) {
    var eventData = eventsData[eventId];
    if (eventData.name === eventName) {
      return eventId;
    }
  }

  return null;
}

function deleteEvent(eventId) {
  if (!eventId) {
    throw new Error('No event ID provided');
  }
  const deleteUrl = `https://test-lab-a4a12-default-rtdb.europe-west1.firebasedatabase.app/events/${eventId}.json`;
  var response = http.delete(deleteUrl);

  if (response.status !== 200) {
    throw new Error(`Failed to delete event: ${response.status}`);
  }

  return true;
}


function main() {
  try {
    // TODO store event name in an environment variable
    const eventName = "ui test event";

    const eventId = getEventIdByName(eventName);
    if (!eventId) {
      console.log(`No event found with name: ${eventName}`);
      return;
    }
    const deleted = deleteEvent(eventId);
    console.log(`Event deleted successfully`);
  } catch (error) {
    console.log(`Error: ${error.message}`);
  }
}

main();