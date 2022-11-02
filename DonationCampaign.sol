// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.7.0 < 0.9.0;

contract DonationCampaign {

    struct Campaign {
        uint256 id;
        string name;
        uint256 targetAmount;
        uint256 amountCollected;
    }

    struct Donations {
        string name;
        address donorAddress;
        uint256 amount;
        uint256 campaignId;
    }

    Campaign[] campaignList;
    Donations[] donations;

    function addCampaign (string memory name, uint256 targetAmount) public {
        Campaign memory newCampaign = Campaign({
            id: campaignList.length,
            name: name,
            amountCollected: 0,
            targetAmount: targetAmount
        });
        campaignList.push(newCampaign);
    }

    
    function donate(string memory name, address donorAddress, uint256 amount, uint256 campaignId) public payable returns(Donations[] memory) {
        require(campaignList.length > 0,"Error: No campaigns");
        for (uint i = 0; i < campaignList.length; i++) {
            if(campaignList[i].id == campaignId) {
                require(campaignList[i].amountCollected < campaignList[i].targetAmount,"Error: Target Amount reached");
                require(amount < campaignList[i].targetAmount,"Error: Too large amount");
                campaignList[i].amountCollected = amount + campaignList[i].amountCollected;
                Donations memory donation = Donations(name,donorAddress,amount,campaignId);
                donations.push(donation);
            }
        }
        return donations;
    }

    function getDonations() external view returns (Donations[] memory){
        return donations;
    }

    function getCampaignList() external view returns (Campaign[] memory) {
        return campaignList;
    }
    
}