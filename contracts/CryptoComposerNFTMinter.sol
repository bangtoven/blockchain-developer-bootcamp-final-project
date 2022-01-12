// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/// @title Contract to mint music NFT
/// @author Jungho Bang
/// @notice Allows users to mint their song
contract CryptoComposerNFTMinter is ERC721, ERC721Enumerable, ERC721Burnable {
	event CCNFTMinted(
		address indexed by,
		string title,
		uint256 id,
		bytes32 hash
	);

	struct Song {
		address composer;
		string title;
		bytes notes;
		bytes32 hash;
	}

	constructor() ERC721("CryptoComposer", "CC") {}

	mapping(uint256 => Song) public songs;

	mapping(bytes32 => bool) private hashes;

	function _mintNewSong(string memory title, bytes memory notes)
		internal
		returns (uint256)
	{
		bytes32 hash = keccak256(notes);
		require(hashes[hash] == false, "Duplicate notes data exist");

		uint256 tokenId = _tokenIdCounter.current();
		_tokenIdCounter.increment();
		_safeMint(msg.sender, tokenId);
		songs[tokenId] = Song({
			composer: msg.sender,
			title: title,
			notes: notes,
			hash: hash
		});

		hashes[hash] = true;

		emit CCNFTMinted(msg.sender, title, tokenId, hash);

		return tokenId;
	}

	function burn(uint256 tokenId) public override {
		super.burn(tokenId);

		bytes32 hash = songs[tokenId].hash;
		hashes[hash] = false;
	}

	// The following lines are generated by OpenZeppelin Wizard

	using Counters for Counters.Counter;

	Counters.Counter private _tokenIdCounter;

	function _baseURI() internal pure override returns (string memory) {
		return "http://crypto-composer.bangtoven.com/songs/";
	}

	// The following functions are overrides required by Solidity.

	function _beforeTokenTransfer(
		address from,
		address to,
		uint256 tokenId
	) internal override(ERC721, ERC721Enumerable) {
		super._beforeTokenTransfer(from, to, tokenId);
	}

	function supportsInterface(bytes4 interfaceId)
		public
		view
		override(ERC721, ERC721Enumerable)
		returns (bool)
	{
		return super.supportsInterface(interfaceId);
	}
}
