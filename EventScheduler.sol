// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract EventScheduler {
    struct Event {
        string title;
        string description;
        uint256 startDate;
        uint256 endDate;
        bool canceled;
    }

    Event[] public events;

    event EventScheduled(uint256 indexed eventId, string title, string description, uint256 startDate, uint256 endDate);
    event EventCanceled(uint256 indexed eventId);

    function scheduleEvent(string memory _title, string memory _description, uint256 _startDate, uint256 _endDate) public {
        require(_startDate < _endDate, "Invalid date range");
        events.push(Event({
            title: _title,
            description: _description,
            startDate: _startDate,
            endDate: _endDate,
            canceled: false
        }));
        emit EventScheduled(events.length - 1, _title, _description, _startDate, _endDate);
    }

    function cancelEvent(uint256 _eventId) public {
        Event storage event_ = events[_eventId];
        require(!event_.canceled, "Event already canceled");
        event_.canceled = true;
        emit EventCanceled(_eventId);
    }
}