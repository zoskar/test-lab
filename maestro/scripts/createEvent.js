function createTestEvent(eventName) {

    const eventId = `test-${Date.now()}`;

    const event = {
        name: eventName,
        eventType: 'Meetup',
        isOnline: true,
        isRecorded: false,
        guestCount: 20,
        date: '2025-04-20',
        time: '15:15',
        themeColor: 4294950020,
        notificationsEnabled: false
    };


    const createUrl = `https://test-lab-a4a12-default-rtdb.europe-west1.firebasedatabase.app/events/${eventId}.json`;
    var response = http.put(createUrl, {
        body: JSON.stringify(event),
        headers: { 'Content-Type': 'application/json' }
    });

    if (response.status !== 200) {
        throw new Error(`Failed to create event: ${response.status} - ${response.body}`);
    }

    console.log(`Event created successfully with ID: ${eventId}`);
    return eventId;
}

function main() {
    try {
        // TODO configure event name in an environment variable
        const eventName = "ui test event";
        const eventId = createTestEvent(eventName);

    } catch (error) {
        console.log(`Error: ${error.message}`);
    }
}

main();