pragma solidity >=0.4.22 <0.6.0;

// @title Pay - Facilitates payments.


contract RegisterMUM {
 uint256 public registerFEE; //Fee to register the mother paid to care provider
 uint256 public registerFUND; //Actual funds donated
 uint256 public mumHEALTHnumber; //Health record number (i.e. NHS number shared across suppliers)
 string mumNAME; //Name of mother receiving health service
 string carePROVIDERname; //Service coordinator name
 string donorNAME; // Name of donor (i.e. individual or institution)
 address payable public carePROVIDERaddress; //Service coordinator payment address on the blockchain
 address payable public mumCAREcontractADDRESS; //Address of mother's care contract
 uint256 public mumREQUIREDcareFUNDING; //Amount (USD) required to fund care contract  
 
	// Events that will be emitted on changes.
	event RegistrationCOMPLETE(address _mumCAREcontractADDRESS, string _mumNAME, uint256 amou);
	event FundsSENT(address _mumCAREcontractADDRESS, string _mumNAME, uint256 mumHEALTHnumber);
 
  constructor (uint256 _registerFEE, uint256 _mumHEALTHnumber, string memory _mumNAME, string memory _carePROVIDERname, address payable _carePROVIDERaddress)
    	public
    	payable
	{
    	registerFEE = _registerFEE;
    	mumHEALTHnumber = _mumHEALTHnumber;
    	mumNAME = _mumNAME;
    	carePROVIDERname = _carePROVIDERname;
    	carePROVIDERaddress = _carePROVIDERaddress;
	}  

	// @dev Makes a payment.
	// @param _to Address to pay to.
	function donate(uint _donateAMOUNT, string memory _donorNAME) public payable
	{
   	require(registerFEE==_donateAMOUNT,"Wrong donation amount. Please resubmit to match required amount" );
    	registerFUND=_donateAMOUNT;
    	donorNAME=_donorNAME;
	}
    
	function notifyREGISTRATIONcompleted(address payable _mumCAREcontractADDRESS, uint256 _mumREQUIREDcareFUNDING) public payable
	{
    	mumCAREcontractADDRESS = _mumCAREcontractADDRESS;
    	mumREQUIREDcareFUNDING = _mumREQUIREDcareFUNDING;
    	emit RegistrationCOMPLETE(_mumCAREcontractADDRESS, mumNAME, _mumREQUIREDcareFUNDING);
	}
    
	function releaseFUNDS() public payable
	{
    	emit FundsSENT (carePROVIDERaddress, mumNAME, mumHEALTHnumber);
	}
}



