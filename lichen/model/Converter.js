
//获取curve
//CurveController.prototype.getCurveFromController = function()

//获取polygon
//MyArea.prototype.getPolygon = function()

//是否包含polygon
//MyArea.prototype.isIncludedPolygon = function(param1)

//获取polygon几何部分
//MyArea.prototype.getPathPolygon = function()

//判断是否包含Area
//MyArea.prototype.isIncludedArea = function(param1)

//重点观察
//curveCornerHelperClass.prototype.getPaths_eh = function()

function Converter() {
    
}

Converter.outputGeo = function(floor) {
    var holesList = [];
    var areas = floor.mAreas;
    for (var i = 0; i < areas.length; i++) {
        var area = areas[i];
        holesList.push([]);
        for (var j = 0; j < areas.length; j++) {
            if(i == j) {
                continue;
            }
            
            if (area.isIncludedArea(areas[j])) {
                if (holesList[i].length == 0) {
                    holesList[i].push(areas[j]);
                } else {
                    var isAdd = true;
                    for (var k = 0; k < holesList[i].length; k++) {
                        if (holesList[i][k].isIncludedArea(areas[j])) {
                            isAdd = false;
                            break;
                        }
                        if (areas[j].isIncludedArea(holesList[i][k])) {
                            holesList[i][k] = areas[j];
                            isAdd = false;
                            break;
                        }
                    }
                    if (isAdd) {
                        holesList[i].push(areas[j]);
                    }
                }
            }
        }
    }

    var result = [];// polyList
    var result2 = [];
    var polyTree = null;
    for (var i = 0; i < areas.length; i++) {
        var res = MyArea.outputStructures(areas[i], holesList[i]);
        var res2 = MyArea.outputStructures2(areas[i], holesList[i]);
        result.push(res);
        result2.push(res2);
    }
    console.log("GEOM INFO:");
    console.log(result);
    return [result, result2];
}
