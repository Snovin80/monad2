// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract DocumentRegistry {
    struct Document {
        string title;
        string contentHash;
        uint256 timestamp;
        bool valid;
    }

    mapping(uint256 => Document) public documents;
    uint256 public documentCount;

    event DocumentAdded(uint256 indexed documentId, string title, string contentHash);
    event DocumentRevoked(uint256 indexed documentId);

    function addDocument(string memory _title, string memory _contentHash) public {
        documentCount++;
        documents[documentCount] = Document({
            title: _title,
            contentHash: _contentHash,
            timestamp: block.timestamp,
            valid: true
        });
        emit DocumentAdded(documentCount, _title, _contentHash);
    }

    function revokeDocument(uint256 _documentId) public {
        require(documents[_documentId].valid, "Document already revoked");
        documents[_documentId].valid = false;
        emit DocumentRevoked(_documentId);
    }

    function getDocument(uint256 _documentId) public view returns (string memory title, string memory contentHash, uint256 timestamp, bool valid) {
        Document memory doc = documents[_documentId];
        return (doc.title, doc.contentHash, doc.timestamp, doc.valid);
    }
}