// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;


import {Hooks} from "@uniswap/v4-core/contracts/libraries/Hooks.sol";
import {IPoolManager} from "@uniswap/v4-core/contracts/interfaces/IPoolManager.sol";
import {BalanceDelta} from "@uniswap/v4-core/contracts/types/BalanceDelta.sol";


contract Router {
  error NotPoolManager();
  error NotSelf();
  error InvalidPool();
  error LockFailure();
  error HookNotImplemented();

  /// @notice The address of the pool manager
  IPoolManager public immutable poolManager;

  /// @dev Only the pool manager may call this function
  modifier poolManagerOnly() {
    if (msg.sender != address(poolManager)) revert NotPoolManager();
    _;
  }


  constructor(IPoolManager _poolManager) {
    poolManager = _poolManager;
  }
  

  function getHooksCalls() public pure returns (Hooks.Calls memory) {
    return Hooks.Calls({
      beforeInitialize: true,
      afterInitialize: true,
      beforeModifyPosition: true,
      afterModifyPosition: true,
      beforeSwap: true,
      afterSwap: true,
      beforeDonate: true,
      afterDonate: true
    });
  }












  uint8 public beforeInitializeCount;
  uint8 public afterInitializeCount;
  uint8 public beforeModifyPositionCount;
  uint8 public afterModifyPositionCount;
  uint8 public beforeSwapCount;
  uint8 public afterSwapCount;
  uint8 public beforeDonateCount;
  uint8 public afterDonateCount;
  
  mapping(uint => mapping(uint => bytes32)) public hooksAddr;




  function getTotalHooks(uint8 hookType) public view returns (uint8 _total){
      if(hookType == 0){  _total = beforeInitializeCount; } 
      else if(hookType == 1){ _total = afterInitializeCount; } 
      else if(hookType == 2){ _total = beforeModifyPositionCount; } 
      else if(hookType == 3){ _total = afterModifyPositionCount; } 
      else if(hookType == 4){ _total = beforeSwapCount; } 
      else if(hookType == 5){ _total = afterSwapCount; } 
      else if(hookType == 6){ _total = beforeDonateCount; } 
      else if(hookType == 7){ _total = afterDonateCount; }
  }


  function setTotalHooks(uint8 hookType, uint8 total) internal {
      if(hookType == 0){ beforeInitializeCount = total; } 
      else if(hookType == 1){ afterInitializeCount = total; } 
      else if(hookType == 2){ beforeModifyPositionCount = total; } 
      else if(hookType == 3){ afterModifyPositionCount = total; } 
      else if(hookType == 4){ beforeSwapCount = total; } 
      else if(hookType == 5){ afterSwapCount = total; } 
      else if(hookType == 6){ beforeDonateCount = total; } 
      else if(hookType == 7){ afterDonateCount = total; }
  }











  
  

  function beforeInitialize(address, IPoolManager.PoolKey calldata, uint160) external poolManagerOnly returns (bytes4) {
    return Router.beforeInitialize.selector;
  }

  function afterInitialize(address, IPoolManager.PoolKey calldata, uint160, int24)
    external
    poolManagerOnly
    returns (bytes4)
  {
    return Router.afterInitialize.selector;
  }



  function beforeModifyPosition(address, IPoolManager.PoolKey calldata, IPoolManager.ModifyPositionParams calldata)
    external
    poolManagerOnly
    returns (bytes4)
  {
    return Router.beforeModifyPosition.selector;
  }

  function afterModifyPosition(
    address,
    IPoolManager.PoolKey calldata,
    IPoolManager.ModifyPositionParams calldata,
    BalanceDelta
  ) external poolManagerOnly returns (bytes4) {
    return Router.afterModifyPosition.selector;
  }



  function beforeSwap(address, IPoolManager.PoolKey calldata, IPoolManager.SwapParams calldata)
    external
    poolManagerOnly
    returns (bytes4)
  {
    return Router.beforeSwap.selector;
  }

  function afterSwap(address, IPoolManager.PoolKey calldata, IPoolManager.SwapParams calldata, BalanceDelta)
    external
    poolManagerOnly
    returns (bytes4)
  {
    return Router.afterSwap.selector;
  }



  function beforeDonate(address, IPoolManager.PoolKey calldata, uint256, uint256) external poolManagerOnly returns (bytes4) {
    return Router.beforeDonate.selector;
  }

  function afterDonate(address, IPoolManager.PoolKey calldata, uint256, uint256) external poolManagerOnly returns (bytes4) {
    return Router.afterDonate.selector;
  }











    // swap fee for hook
    function getHookSwapFee(bytes memory key) external returns (uint8){}

    // withdraw fee for hook
    function getHookWithdrawFee(bytes memory key) external returns (uint8){}



    // dynamic swap fee for LP providers
    function getFee(bytes memory key) external returns (uint24){}
}