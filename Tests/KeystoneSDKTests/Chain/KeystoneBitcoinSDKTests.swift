//
//  KeystoneBitcoinSDKTests.swift
//  
//
//  Created by LiYan on 3/30/23.
//

import Foundation
import XCTest
@testable import KeystoneSDK


final class KeystoneBitcoinSDKTests: XCTestCase {
    
    func testParsePsbt() {
        let psbtCborHex = "58A770736274FF01009A020000000258E87A21B56DAF0C23BE8E7070456C336F7CBAA5C8757924F545887BB2ABDD750000000000FFFFFFFF838D0427D0EC650A68AA46BB0B098AEA4422C071B2CA78352A077959D07CEA1D0100000000FFFFFFFF0270AAF00800000000160014D85C2B71D0060B09C9886AEB815E50991DDA124D00E1F5050000000016001400AEA9A2E5F0F876A588DF5546E8742D1D87008F000000000000000000"
        
        let bitcoinSdk = KeystoneBitcoinSDK()
        let psbt = try! bitcoinSdk.parsePSBT(cborHex: psbtCborHex)
        
        XCTAssertEqual(psbt, "70736274FF01009A020000000258E87A21B56DAF0C23BE8E7070456C336F7CBAA5C8757924F545887BB2ABDD750000000000FFFFFFFF838D0427D0EC650A68AA46BB0B098AEA4422C071B2CA78352A077959D07CEA1D0100000000FFFFFFFF0270AAF00800000000160014D85C2B71D0060B09C9886AEB815E50991DDA124D00E1F5050000000016001400AEA9A2E5F0F876A588DF5546E8742D1D87008F000000000000000000".hexadecimal)
    }

    func testParsePsbtError() {
        let psbtCborHex = "58A770736274FF01009A020000000258E87A21B56DAF0C23BE8E7070456C336F7CBAA5C8757924F545887BB2ABDD750000000000FFFFFFFF838D0427D0EC650A68AA46BB0B098AEA4422C071B2CA78352A077959D07CEA1D0100000000FFFFFFFF0270AAF00800000000160014D85C2B71D0060B09C9886AEB815E50991DDA124D00E1F5050000000016001400AEA9A2E5F0F876A588DF5546E8742D1D87008"
        let bitcoinSdk = KeystoneBitcoinSDK()

        var thrownError: Swift.Error?
        XCTAssertThrowsError(try bitcoinSdk.parsePSBT(cborHex: psbtCborHex)) {
             thrownError = $0
        }
        XCTAssertEqual(thrownError as? KeystoneError, .parsePSBTError("PSBT is invalid"))
    }

    func testGeneratePsbtUR() {
        let psbtHex = "70736274FF01009A020000000258E87A21B56DAF0C23BE8E7070456C336F7CBAA5C8757924F545887BB2ABDD750000000000FFFFFFFF838D0427D0EC650A68AA46BB0B098AEA4422C071B2CA78352A077959D07CEA1D0100000000FFFFFFFF0270AAF00800000000160014D85C2B71D0060B09C9886AEB815E50991DDA124D00E1F5050000000016001400AEA9A2E5F0F876A588DF5546E8742D1D87008F000000000000000000"

        let bitcoinSdk = KeystoneBitcoinSDK()
        let psbtEncoder = try! bitcoinSdk.generatePSBT(psbt: psbtHex.hexadecimal)

        XCTAssertEqual(psbtEncoder.nextPart(), "ur:crypto-psbt/hdosjojkidjyzmadaenyaoaeaeaeaohdvsknclrejnpebncnrnmnjojofejzeojlkerdonspkpkkdkykfelokgprpyutkpaeaeaeaeaezmzmzmzmlslgaaditiwpihbkispkfgrkbdaslewdfycprtjsprsgksecdratkkhktikewdcaadaeaeaeaezmzmzmzmaojopkwtayaeaeaeaecmaebbtphhdnjstiambdassoloimwmlyhygdnlcatnbggtaevyykahaeaeaeaecmaebbaeplptoevwwtyakoonlourgofgvsjydpcaltaemyaeaeaeaeaeaeaeaeaebkgdcarh")
    }
}