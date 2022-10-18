// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Compare {
    bytes32[] words;
    uint256 private constant count_words = 50;

    function write_words() public {
        for (uint256 i = 0; i < count_words; i++) {
            words.push(random_word());
        }
    }

    function random_word() private view returns (bytes32) {
        return keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender));
    }

    function show_record(uint i) public view returns (bytes32) {
        return words[i];
    }

    // ===================== SUM 9-16 bit ========================

    function calc_9_16() public view returns (uint256 sum) {
        for (uint256 i = 0; i < words.length; i++) {
            sum += get_9_16(words[i]);
        }
    }

    function get_9_16(bytes32 word) private pure returns (uint256) {
        uint8 value;
        assembly {
            mstore(0x20, word)
            value := mload(0x2)
        }
        return uint256(value);
    }

    // ===================== SUM 10-20 bit ========================

    function calc_10_20() public view returns (uint256 sum) {
        for (uint256 i = 0; i < words.length; i++) {
            sum += get_10_20(words[i]);
        }
    }

    function get_10_20(bytes32 word) private pure returns (uint256) {
        uint16 value;
        assembly {
            mstore(0x20, word)
            value := and(shr(5, mload(0x3)), 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3FF)
        }
        return uint256(value);
    }
}
