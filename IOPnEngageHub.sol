// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract IOPnEngageHub {

    string public creator = "malamsunyi94";
    string public ecosystem = "IOPn / OPN Chain";

    mapping(address => uint256) public points;
    mapping(address => uint256) public totalCheckIns;
    mapping(address => uint256) public lastCheckIn;
    mapping(address => uint256) public totalActions;

    event ActionLogged(
        address indexed user,
        string actionName,
        uint256 pointsAfter,
        uint256 timestamp
    );

    function dailyCheckIn() external {
        require(
            block.timestamp >= lastCheckIn[msg.sender] + 1 days,
            "Check-in once every 24h"
        );

        totalCheckIns[msg.sender] += 1;
        totalActions[msg.sender] += 1;
        points[msg.sender] += 10;
        lastCheckIn[msg.sender] = block.timestamp;

        emit ActionLogged(
            msg.sender,
            "Daily Check In",
            points[msg.sender],
            block.timestamp
        );
    }

    function engage() external {
        totalActions[msg.sender] += 1;
        points[msg.sender] += 2;

        emit ActionLogged(
            msg.sender,
            "Engage",
            points[msg.sender],
            block.timestamp
        );
    }

    function build() external {
        totalActions[msg.sender] += 1;
        points[msg.sender] += 5;

        emit ActionLogged(
            msg.sender,
            "Build",
            points[msg.sender],
            block.timestamp
        );
    }

    function supportNetwork() external {
        totalActions[msg.sender] += 1;
        points[msg.sender] += 3;

        emit ActionLogged(
            msg.sender,
            "Support Network",
            points[msg.sender],
            block.timestamp
        );
    }

    function getMyStats()
        external
        view
        returns (
            uint256 myPoints,
            uint256 myCheckIns,
            uint256 myActions,
            uint256 nextCheckIn
        )
    {
        return (
            points[msg.sender],
            totalCheckIns[msg.sender],
            totalActions[msg.sender],
            lastCheckIn[msg.sender] + 1 days
        );
    }
}
