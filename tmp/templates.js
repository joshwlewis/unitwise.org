this.JST = {"calculation": function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<div class="form-group"><div class="col-md-5 left-container"></div><div class="col-md-2 operator-container"><div class="form-group"><div class="col-sm-12"><label for="operator" class="control-label">Operator</label><select name="operator" class="form-control"><option value="convert_to">&#8658;</option><option value="+">+</option><option value="-">-</option><option value="*">*</option><option value="/">/</option></select></div></div></div><div class="col-md-5 right-container"></div></div><div class="result-container"></div>';

}
return __p
},
"measurement": function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<div class="form-group"><div class="col-sm-5 value-container"><label for="value" class="control-label">Magnitude</label><input type="number" name="value" value="{{ value }}" required="required" class="form-control"/></div><div class="col-sm-7 unit-container"></div></div>';

}
return __p
},
"unit": function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<div class="row"><div class="col-sm-12"><label for="code" class="control-label">Unit</label><select name="code" required="required"></select></div></div>';

}
return __p
}};