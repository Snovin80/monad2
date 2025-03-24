// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract ProjectManagement {
    struct Project {
        string title;
        string description;
        address manager;
        uint256 startDate;
        uint256 endDate;
        bool completed;
    }

    Project[] public projects;

    event ProjectStarted(uint256 indexed projectId, string title, string description, address manager, uint256 startDate, uint256 endDate);
    event ProjectCompleted(uint256 indexed projectId);

    function startProject(string memory _title, string memory _description, uint256 _startDate, uint256 _endDate) public {
        require(_startDate < _endDate, "Invalid date range");
        projects.push(Project({
            title: _title,
            description: _description,
            manager: msg.sender,
            startDate: _startDate,
            endDate: _endDate,
            completed: false
        }));
        emit ProjectStarted(projects.length - 1, _title, _description, msg.sender, _startDate, _endDate);
    }

    function completeProject(uint256 _projectId) public {
        Project storage project = projects[_projectId];
        require(project.manager == msg.sender, "Not project manager");
        require(!project.completed, "Project already completed");
        project.completed = true;
        emit ProjectCompleted(_projectId);
    }
}