// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract TaskManager {
    struct Task {
        string title;
        string description;
        address assignee;
        bool completed;
    }

    Task[] public tasks;

    event TaskCreated(uint256 indexed taskId, string title, string description, address assignee);
    event TaskCompleted(uint256 indexed taskId, address completer);

    function createTask(string memory _title, string memory _description, address _assignee) public {
        tasks.push(Task({
            title: _title,
            description: _description,
            assignee: _assignee,
            completed: false
        }));
        emit TaskCreated(tasks.length - 1, _title, _description, _assignee);
    }

    function completeTask(uint256 _taskId) public {
        Task storage task = tasks[_taskId];
        require(task.assignee == msg.sender, "Not assigned to this task");
        require(!task.completed, "Task already completed");
        task.completed = true;
        emit TaskCompleted(_taskId, msg.sender);
    }
}