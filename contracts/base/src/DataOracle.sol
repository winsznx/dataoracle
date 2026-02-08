// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title DataOracle
 * @notice Decentralized data feed with validator consensus
 */
contract DataOracle {
    error NotValidator();
    error AlreadySubmitted();

    event DataSubmitted(bytes32 indexed key, address indexed validator, uint256 value);
    event ConsensusReached(bytes32 indexed key, uint256 value);

    struct DataPoint {
        uint256 value;
        uint256 submissions;
        mapping(address => bool) submitted;
        mapping(uint256 => uint256) votes;
    }

    mapping(bytes32 => DataPoint) public dataPoints;
    mapping(address => bool) public validators;
    uint256 public consensusThreshold = 3;

    constructor(address[] memory _validators) {
        for (uint256 i = 0; i < _validators.length; i++) {
            validators[_validators[i]] = true;
        }
    }

    function submit(bytes32 key, uint256 value) external {
        if (!validators[msg.sender]) revert NotValidator();
        DataPoint storage dp = dataPoints[key];
        if (dp.submitted[msg.sender]) revert AlreadySubmitted();
        
        dp.submitted[msg.sender] = true;
        dp.votes[value]++;
        dp.submissions++;
        
        emit DataSubmitted(key, msg.sender, value);
        
        if (dp.votes[value] >= consensusThreshold) {
            dp.value = value;
            emit ConsensusReached(key, value);
        }
    }

    function getData(bytes32 key) external view returns (uint256) {
        return dataPoints[key].value;
    }

    function getSubmissions(bytes32 key) external view returns (uint256) {
        return dataPoints[key].submissions;
    }
}
