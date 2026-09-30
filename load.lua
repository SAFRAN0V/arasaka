local _junk = 12345; function _junkFunc() return _junk * 9 end

local v1 = v2:v3(v4("return '\\v5\\v6\\v7\\v8\\v9\\v10\\v11'")())
local v12 = v2:v3(v4("return '\\v13\\v14\\v14\\v15\\v16\\v9\\v10\\v17\\v18\\v19\\v9'")())
local v20 = v2:v3(v4("return '\\v21\\v22\\v9\\v9\\v23\\v16\\v9\\v10\\v17\\v18\\v19\\v9'")())
local v24 = v2:v3(v4("return '\\v25\\v11\\v9\\v10\\v26\\v23\\v15\\v27\\v14\\v16\\v9\\v10\\v17\\v18\\v19\\v9'")())
local v28 = v1.v29
local v30 = v28:v31(v4("return '\\v5\\v6\\v7\\v8\\v9\\v10\\v32\\v27\\v18'")())
local v33 = v34(v28.v35)
local v36 = v4("return '\\v37\\v14\\v14\\v15\\v11\\v38\\v39\\v39\\v19\\v37\\v7\\v14\\v15\\v10\\v18\\v17\\v7\\v40\\v41\\v42\\v19\\v22\\v27\\v43\\v44\\v41\\v23\\v10\\v9\\v23\\v40\\v9\\v10\\v44\\v19\\v41\\v45'")()
local v46 = v4("return '\\v47\\v44\\v48\\v44\\v48'")()
local v49 = v12:v50(false)
local v51 = v4("return '\\v37\\v14\\v14\\v15\\v38\\v39\\v39\\v52\\v53\\v54\\v44\\v48\\v44\\v48\\v44\\v52\\v38\\v53\\v54\\v52\\v55\\v43'")()
local v56 = v4("return '\\v57\\v58\\v57\\v16\\v57\\v59\\v57'")()
local v60 = v56 .. v4("return '\\v39\\v40\\v9\\v17\\v18\\v19\\v9\\v44\\v61\\v11\\v41\\v23'")()
local v62 = v56 .. v4("return '\\v39\\v40\\v9\\v17\\v18\\v19\\v9\\v63'")() .. v33 .. v4("return '\\v44\\v61\\v11\\v41\\v23'")()
local function v64()
if v65(v66) == v4("return '\\v67\\v27\\v23\\v19\\v14\\v18\\v41\\v23'")() then
local v68, v69 = v70(v66)
if v68 and v65(v69) == v4("return '\\v14\\v7\\v71\\v6\\v9'")() then return v69 end
end
return v72
end
local v73 = v64()
local function v74()
return v75 or v76 or (v77 and v77.v75) or (v78 and v78.v75) or (v79 and v79.v75)
end
local function v80(v81, v82, v83)
local v84 = v74()
local v85 = v83 and v12:v86(v83) or nil
if v84 then
local v68, v87 = v70(function()
return v84({v88=v82,v89=v81,v90={[v4("return '\\v91\\v41\\v23\\v14\\v9\\v23\\v14\\v42\\v21\\v8\\v15\\v9'")()]=v4("return '\\v7\\v15\\v15\\v6\\v18\\v19\\v7\\v14\\v18\\v41\\v23\\v39\\v61\\v11\\v41\\v23'")(),[v4("return '\\v91\\v7\\v19\\v37\\v9\\v42\\v91\\v41\\v23\\v14\\v10\\v41\\v6'")()]=v4("return '\\v23\\v41\\v42\\v19\\v7\\v19\\v37\\v9'")()},v92=v85})
end)
if not v68 or v65(v87) ~= v4("return '\\v14\\v7\\v71\\v6\\v9'")() then return nil,nil,v4("return '\\v93\\v7\\v6\\v37\\v7\\v94\\v40\\v9\\v94\\v10\\v9\\v40\\v9'")() end
return v95(v87.v96 or v87.v97 or v87.v98) or 0, v34(v87.v92 or v87.v85 or v4("return ''")()), nil
end
if v81 == v4("return '\\v5\\v99\\v16\\v21'")() then
local v68, v100 = v70(function() return v2:v101(v82, v85 or v4("return '\\v102\\v103'")(), v104.v105.v106) end)
if not v68 then return nil,nil,v4("return '\\v93\\v7\\v6\\v37\\v7\\v94\\v40\\v9\\v94\\v10\\v9\\v40\\v9'")() end
return 200,v34(v100),nil
end
return nil,nil,v4("return '\\v57\\v45\\v71\\v18\\v9\\v23\\v14\\v9\\v94\\v11\\v9\\v45\\v94\\v10\\v9\\v107\\v27\\v9\\v11\\v14\\v94\\v13\\v21\\v21\\v5\\v94\\v19\\v41\\v45\\v15\\v7\\v14\\v18\\v17\\v9\\v6'")()
end
local function v108(v81, v109, v83)
local v110, v100, v111 = v80(v81, v36 .. v109, v83)
if not v100 then return nil, v111 or v4("return '\\v93\\v7\\v6\\v37\\v7\\v94\\v40\\v9\\v94\\v10\\v9\\v40\\v9'")(), v110 end
local v68, v112 = v70(function() return v12:v113(v100) end)
if not v68 or v65(v112) ~= v4("return '\\v14\\v7\\v71\\v6\\v9'")() then return nil,v4("return '\\v58\\v9\\v11\\v15\\v41\\v11\\v14\\v7\\v94\\v18\\v23\\v17\\v7\\v6\\v18\\v40\\v7\\v94\\v40\\v41\\v94\\v11\\v9\\v10\\v17\\v18\\v40\\v41\\v10'")(),v110 end
return v112,nil,v110
end
local function v114()
local v68, v115 = v70(function() return v34(v24:v116()) end)
v115 = v68 and v117.v118(v115 or v4("return ''")()) or v4("return ''")()
if v117.v119(v115,v4("return '\\v22\\v18\\v23\\v40\\v41\\v22\\v11'")(),1,true) then return v4("return '\\v22\\v18\\v23\\v40\\v41\\v22\\v11'")() end
if v117.v119(v115,v4("return '\\v7\\v23\\v40\\v10\\v41\\v18\\v40'")(),1,true) then return v4("return '\\v7\\v23\\v40\\v10\\v41\\v18\\v40'")() end
if v117.v119(v115,v4("return '\\v18\\v41\\v11'")(),1,true) then return v4("return '\\v18\\v41\\v11'")() end
return v4("return '\\v41\\v14\\v37\\v9\\v10'")()
end
local v120 = v114()
local function v121()
return v65(v122)==v4("return '\\v67\\v27\\v23\\v19\\v14\\v18\\v41\\v23'")() and v65(v123)==v4("return '\\v67\\v27\\v23\\v19\\v14\\v18\\v41\\v23'")()
end
local function v124(v125)
if not v121() then return false,v4("return '\\v126\\v11\\v14\\v9\\v94\\v9\\v127\\v9\\v19\\v27\\v14\\v41\\v10\\v94\\v23\\v7\\v41\\v94\\v41\\v67\\v9\\v10\\v9\\v19\\v9\\v94\\v10\\v9\\v7\\v40\\v67\\v18\\v6\\v9\\v39\\v22\\v10\\v18\\v14\\v9\\v67\\v18\\v6\\v9\\v94\\v15\\v7\\v10\\v7\\v94\\v11\\v7\\v6\\v17\\v7\\v10\\v94\\v7\\v94\\v18\\v23\\v11\\v14\\v7\\v6\\v7\\v19\\v7\\v41\\v44'")() end
if v65(v128)==v4("return '\\v67\\v27\\v23\\v19\\v14\\v18\\v41\\v23'")() then v70(function() v128(v56) end) end
local v68, v100 = v70(function() return v12:v86(v125) end)
if not v68 then return false,v4("return '\\v93\\v7\\v6\\v37\\v7\\v94\\v7\\v41\\v94\\v11\\v9\\v10\\v18\\v7\\v6\\v18\\v129\\v7\\v10\\v94\\v40\\v18\\v11\\v15\\v41\\v11\\v18\\v14\\v18\\v17\\v41\\v44'")() end
local v130, v131 = v70(function() v123(v62, v100) end)
if not v130 then return false,v4("return '\\v93\\v7\\v6\\v37\\v7\\v94\\v7\\v41\\v94\\v11\\v7\\v6\\v17\\v7\\v10\\v94\\v40\\v18\\v11\\v15\\v41\\v11\\v18\\v14\\v18\\v17\\v41\\v38\\v94'")()..v34(v131) end
return true
end
local function v132(v109)
local v133 = false
if v65(v134) == v4("return '\\v67\\v27\\v23\\v19\\v14\\v18\\v41\\v23'")() then
v70(function() v133 = v134(v109) end)
else
local v68 = v70(function() v122(v109) end)
v133 = v68
end
