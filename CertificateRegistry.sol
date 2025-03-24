// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract CertificateRegistry {
    struct Certificate {
        string title;
        string description;
        uint256 issueDate;
        bool valid;
    }

    mapping(uint256 => Certificate) public certificates;
    uint256 public certificateCount;

    event CertificateIssued(uint256 indexed certificateId, string title, string description);
    event CertificateRevoked(uint256 indexed certificateId);

    function issueCertificate(string memory _title, string memory _description) public {
        certificateCount++;
        certificates[certificateCount] = Certificate({
            title: _title,
            description: _description,
            issueDate: block.timestamp,
            valid: true
        });
        emit CertificateIssued(certificateCount, _title, _description);
    }

    function revokeCertificate(uint256 _certificateId) public {
        require(certificates[_certificateId].valid, "Certificate already revoked");
        certificates[_certificateId].valid = false;
        emit CertificateRevoked(_certificateId);
    }

    function getCertificate(uint256 _certificateId) public view returns (string memory title, string memory description, uint256 issueDate, bool valid) {
        Certificate memory cert = certificates[_certificateId];
        return (cert.title, cert.description, cert.issueDate, cert.valid);
    }
}