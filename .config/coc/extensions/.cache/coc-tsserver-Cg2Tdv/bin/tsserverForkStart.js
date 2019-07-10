/*---------------------------------------------------------------------------------------------
 *  Copyright (c) Microsoft Corporation. All rights reserved.
 *  Licensed under the MIT License. See License.txt in the project root for license information.
 *--------------------------------------------------------------------------------------------*/
let net = require('net');
let fs = require('fs');
let ENABLE_LOGGING = false;
let log = (function () {
    if (!ENABLE_LOGGING) {
        return function () { }; // tslint:disable-line
    }
    let isFirst = true;
    let LOG_LOCATION = 'C:\\stdFork.log';
    return function log(str) {
        if (isFirst) {
            isFirst = false;
            fs.writeFileSync(