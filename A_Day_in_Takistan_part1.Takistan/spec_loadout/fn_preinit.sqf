// We set the markers invisible (if you use more then 100 markers, then increase). Or delete if you want them visible
for "_x" from 1 to 100 do {
    format ["%1",_x] setMarkerAlpha 0;
};
