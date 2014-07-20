this.JST = {"calculation": function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<div class="form-group"><div class="col-xs-9 col-xs-offset-3 left-container"></div></div><div class="form-group"><div class="col-xs-3 operator-container"><label for="operator" class="control-label">Operator</label><select name="operator" class="form-control"><option value="convert_to">&#8658;</option><option value="+">+</option><option value="-">-</option><option value="*">*</option><option value="/">/</option></select></div><div class="col-xs-9 right-container"></div></div><div class="result-container"></div>';

}
return __p
},
"measurement": function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<div class="col-xs-5 value-container"><label for="value" class="control-label">Magnitude</label><input type="number" name="value" value="{{ value }}" required="required" class="form-control"/></div><div class="col-xs-7 unit-container"></div>';

}
return __p
},
"unit": function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<label for="code" class="control-label">Unit</label><select name="code" required="required"></select>';

}
return __p
}};