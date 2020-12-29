'use strict';
var Args = process.argv;
var FILE = Args[2];
var PASSWORD = Args[3];

const fs = require('fs');
const JSON5 = require ('json5');
let rawdata = fs.readFileSync(FILE);
let settings =JSON5.parse(rawdata);
settings["users"]["admin"]["password"]=PASSWORD

console.log(JSON.stringify(settings,undefined,5));




//console.log(settings);


