// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract FeedbackSystem {
    struct Feedback {
        string title;
        string content;
        uint256 timestamp;
        address sender;
    }

    Feedback[] public feedbacks;

    event FeedbackSubmitted(uint256 indexed feedbackId, string title, string content, address sender);

    function submitFeedback(string memory _title, string memory _content) public {
        feedbacks.push(Feedback({
            title: _title,
            content: _content,
            timestamp: block.timestamp,
            sender: msg.sender
        }));
        emit FeedbackSubmitted(feedbacks.length - 1, _title, _content, msg.sender);
    }

    function getFeedback(uint256 _feedbackId) public view returns (string memory title, string memory content, uint256 timestamp, address sender) {
        Feedback memory feedback = feedbacks[_feedbackId];
        return (feedback.title, feedback.content, feedback.timestamp, feedback.sender);
    }
}