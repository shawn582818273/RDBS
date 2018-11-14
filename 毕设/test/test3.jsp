<!DOCTYPE html>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css">
    <script type="text/javascript" src="./js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="./js/bootstrap.min.js"></script>
    <script type="text/javascript" src="./js/echarts.js"></script>
</head>
<body>
    <div class="col-xs-4">
            <h3>条形图</h3>
            <div id="main" style="width: 500px;height: 400px;"></div>
            <script type="text/javascript">
            var myChart = echarts.init(document.getElementById("main"));
            var option = {
                title:{
                    text:"第一个图标演示示例"
                },
                tooltip:{
                    text:"this is tool tip"
                },
                legend:{
                    data:['销量']
                },
                xAxis:{
                    data:["寸衫","羊毛衫","裤子","袜子","皮鞋","帽子"]
                },
                yAxis:{},
                series:[{
                            name:["销量"],
                            type:"bar",
                            data:[5,20,36,6,43,67]
                        }]
            };

            // myChart.setOption(option);

            myChart.setOption({
                title:{
                    text:"第一个图标演示示例"
                },
                tooltip:{
                    text:"this is tool tip"
                },
                legend:{
                    data:['销量']
                },
                xAxis:{
                    data:["寸衫","羊毛衫","裤子","袜子","皮鞋","帽子"]
                },
                yAxis:{},
                series:[{
                            name:["销量"],
                            type:"bar",
                            data:[5,20,36,6,43,67]
                        }]
            });

        </script>
    </div>
    <div class="col-xs-4">
        <h3>饼状图</h3>
        <div id="tbSecond" style="width: 500px;height: 400px;"></div>
        <script type="text/javascript">
            var tbSecond = echarts.init(document.getElementById("tbSecond"));
            // alert(tbSecond);
            var pieOption = {
                    title:{
                        text:"饼状图"
                    },
                    series : [
                        {
                            name: '访问来源',
                            type: 'pie',
                            radius: '55%',
                            data:[
                                {value:235, name:'视频广告'},
                                {value:274, name:'联盟广告'},
                                {value:310, name:'邮件营销'},
                                {value:335, name:'直接访问'},
                                {value:400, name:'搜索引擎'}
                            ]
                        }
                    ]
                };
            // alert(pieOption);
            tbSecond.setOption(pieOption);

        </script>
    </div>
    <div class="col-xs-4">
        <h3>饼状图加阴影</h3>
        <div id="bzt2" style="width: 500px;height: 400px;"></div>
        <script type="text/javascript">
            var bzt2 = echarts.init(document.getElementById("bzt2"));
            bzt2.setOption({
                title:{
                        text:"饼状图"
                    },
                itemStyle:{
                    emphasis:{
                        shadowBlur:200,
                        shadowColor:"rgba(0,0,0,0.8)"
                    }
                },
                series:[
                        {
                            name: '访问来源',
                            type: 'pie',
                            radius: '55%',
                            data:[
                                {value:235, name:'视频广告'},
                                {value:274, name:'联盟广告'},
                                {value:310, name:'邮件营销'},
                                {value:335, name:'直接访问'},
                                {value:400, name:'搜索引擎'}
                            ]
                        }
                    ]       
            });
        </script>
    </div>
    <div class="col-xs-4">
        <h3>饼状图加背景</h3>
        <div id="bzt3" style="width: 500px;height: 400px;"></div>
        <script type="text/javascript">
            var bzt3 = echarts.init(document.getElementById("bzt3"));
            bzt3.setOption({
                title:{
                        text:"饼状图"
                    },
                backgroundColor:"#EEEFF4",
                itemStyle:{
                    emphasis:{
                        shadowBlur:200,
                        shadowColor:"rgba(0,0,0,0.8)"
                    }
                },
                series:[
                        {
                            name: '访问来源',
                            type: 'pie',
                            radius: '55%',
                            data:[
                                {value:235, name:'视频广告'},
                                {value:274, name:'联盟广告'},
                                {value:310, name:'邮件营销'},
                                {value:335, name:'直接访问'},
                                {value:400, name:'搜索引擎'}
                            ]
                        }
                    ]
            });
        </script>
    </div>
    <div class="col-xs-4">
        <h3>放大缩小</h3>
        <div id="dataZoom" style="width: 500px;height: 400px;"></div>
        <script type="text/javascript">
            var dataZoom = echarts.init($("#dataZoom")[0]);
            dataZoom.setOption(
                {       
                    xAxis:{
                                    type:"value"
                                },
                                yAxis:{
                                    type:"value"
                                },
                                dataZoom:[
                                    {
                                        type:"slider",
                                        start:10,
                                        end:60
                                    }
                                ],
                                series:[
                                    {
                                        type:"scatter",
                                        itemStyle:{
                                            normal:{
                                                opacity:0.8
                                            }
                                        },
                                        symbolSize:function(val)
                                        {
                                            return val[2] * 40;
                                        },
                                        data:[["14.616","7.241","0.896"],["3.958","5.701","0.955"],["2.768","8.971","0.669"],["9.051","9.710","0.171"],["14.046","4.182","0.536"],["12.295","1.429","0.962"],["4.417","8.167","0.113"],["0.492","4.771","0.785"],["7.632","2.605","0.645"],["14.242","5.042","0.368"]]
                                    }
            ]});
        </script>
    </div>
    <div class="col-xs-4">
        <h3>Scatter-large</h3>
        <div id="sl" style="width: 500px;height: 400px;"></div>
        <script type="text/javascript">
            var sl = echarts.init($("#sl")[0]);
            var sloption = {
                            tooltip : {
                                trigger: 'axis',
                                showDelay : 0,
                                axisPointer:{
                                    show: true,
                                    type : 'cross',
                                    lineStyle: {
                                        type : 'dashed',
                                        width : 1
                                    }
                                },
                                zlevel: 1
                            },
                            legend: {
                                data:['sin','cos']
                            },
                            toolbox: {
                                show : true,
                                feature : {
                                    mark : {show: true},
                                    dataZoom : {show: true},
                                    dataView : {show: true, readOnly: false},
                                    restore : {show: true},
                                    saveAsImage : {show: true}
                                }
                            },
                            xAxis : [
                                {
                                    type : 'value',
                                    scale:true
                                }
                            ],
                            yAxis : [
                                {
                                    type : 'value',
                                    scale:true
                                }
                            ],
                            series : [
                                {
                                    name:'sin',
                                    type:'scatter',
                                    large: true,
                                    symbolSize: 3,
                                    data: (function () {
                                        var d = [];
                                        var len = 10000;
                                        var x = 0;
                                        while (len--) {
                                            x = (Math.random() * 10).toFixed(3) - 0;
                                            d.push([
                                                x,
                                                //Math.random() * 10
                                                (Math.sin(x) - x * (len % 2 ? 0.1 : -0.1) * Math.random()).toFixed(3) - 0
                                            ]);
                                        }
                                        //console.log(d)
                                        return d;
                                    })()
                                },
                                {
                                    name:'cos',
                                    type:'scatter',
                                    large: true,
                                    symbolSize: 2,
                                    data: (function () {
                                        var d = [];
                                        var len = 20000;
                                        var x = 0;
                                        while (len--) {
                                            x = (Math.random() * 10).toFixed(3) - 0;
                                            d.push([
                                                x,
                                                //Math.random() * 10
                                                (Math.cos(x) - x * (len % 2 ? 0.1 : -0.1) * Math.random()).toFixed(3) - 0
                                            ]);
                                        }
                                        //console.log(d)
                                        return d;
                                    })()
                                }
                            ]
                        };

            sl.setOption(sloption);
        </script>
    </div>
    <div class="col-xs-4">
        <h3>微博签到</h3>
        <div id="qd" style="width: 500px;height: 400px;"></div>
        <script type="text/javascript">
            var qd = echarts.init($("#qd")[0]);
            qd.showLoading();

            $.get('http://echarts.baidu.com/gallery/data/asset/data/weibo.json', function (weiboData) {
                qd.hideLoading();

                weiboData = weiboData.map(function (serieData, idx) {
                    var px = serieData[0] / 1000;
                    var py = serieData[1] / 1000;
                    var res = [[px, py]];

                    for (var i = 2; i < serieData.length; i += 2) {
                        var dx = serieData[i] / 1000;
                        var dy = serieData[i + 1] / 1000;
                        var x = px + dx;
                        var y = py + dy;
                        res.push([x, y, 1]);

                        px = x;
                        py = y;
                    }
                    return res;
                });
                qd.setOption(option = {
                    backgroundColor: '#404a59',
                    title : {
                        text: '微博签到数据点亮中国',
                        subtext: 'From ThinkGIS',
                        sublink: 'http://www.thinkgis.cn/public/sina',
                        left: 'center',
                        top: 'top',
                        textStyle: {
                            color: '#fff'
                        }
                    },
                    legend: {
                        left: 'left',
                        data: ['强', '中', '弱'],
                        textStyle: {
                            color: '#ccc'
                        }
                    },
                    geo: {
                        name: '强',
                        type: 'scatter',
                        map: 'china',
                        label: {
                            emphasis: {
                                show: false
                            }
                        },
                        itemStyle: {
                            normal: {
                                areaColor: '#323c48',
                                borderColor: '#111'
                            },
                            emphasis: {
                                areaColor: '#2a333d'
                            }
                        }
                    },
                    series: [{
                        name: '弱',
                        type: 'scatter',
                        coordinateSystem: 'geo',
                        symbolSize: 1,
                        large: true,
                        itemStyle: {
                            normal: {
                                shadowBlur: 2,
                                shadowColor: 'rgba(37, 140, 249, 0.8)',
                                color: 'rgba(37, 140, 249, 0.8)'
                            }
                        },
                        data: weiboData[0]
                    }, {
                        name: '中',
                        type: 'scatter',
                        coordinateSystem: 'geo',
                        symbolSize: 1,
                        large: true,
                        itemStyle: {
                            normal: {
                                shadowBlur: 2,
                                shadowColor: 'rgba(14, 241, 242, 0.8)',
                                color: 'rgba(14, 241, 242, 0.8)'
                            }
                        },
                        data: weiboData[1]
                    }, {
                        name: '强',
                        type: 'scatter',
                        coordinateSystem: 'geo',
                        symbolSize: 1,
                        large: true,
                        itemStyle: {
                            normal: {
                                shadowBlur: 2,
                                shadowColor: 'rgba(255, 255, 255, 0.8)',
                                color: 'rgba(255, 255, 255, 0.8)'
                            }
                        },
                        data: weiboData[2]
                    }]
                });
            });
        </script>
    </div>
    <div class="col-xs-4">
        <h3>极坐标双轴线</h3>
        <div id="jzb" style="width: 500px;height: 400px;"></div>
        <script type="text/javascript">
            var jzb = echarts.init($("#jzb")[0]);
            var data = [];

            for (var i = 0; i <= 100; i++) {
                var theta = i / 100 * 360;
                var r = 5 * (1 + Math.sin(theta / 180 * Math.PI));
                data.push([r, theta]);
            }

            var jzboption = {
                title: {
                    text: '极坐标双数值轴'
                },
                legend: {
                    data: ['line']
                },
                polar: {},
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'cross'
                    }
                },
                angleAxis: {
                    type: 'value',
                    startAngle: 0
                },
                radiusAxis: {
                },
                series: [{
                    coordinateSystem: 'polar',
                    name: 'line',
                    type: 'line',
                    data: data
                }]
            };

            jzb.setOption(jzboption);
        </script>
    </div>
    <div class="col-xs-4">
        <h3>浏览器占比</h3>
        <div id="llqzb" style="width: 500px;height: 400px;"></div>
        <script type="text/javascript">
            var llqzb = echarts.init($("#llqzb")[0]);
            var llqzboption = {
                    title: {
                        text: '浏览器占比变化',
                        subtext: '纯属虚构',
                        x:'right',
                        y:'bottom'
                    },
                    tooltip: {
                        trigger: 'item',
                        backgroundColor : 'rgba(0,0,250,0.2)'
                    },
                    legend: {
                        data: (function (){
                            var list = [];
                            for (var i = 1; i <=28; i++) {
                                list.push(i + 2000);
                            }
                            return list;
                        })()
                    },
                    visualMap: {
                        color: ['red', 'yellow']
                    },
                    radar: {
                       indicator : [
                           { text: 'IE8-', max: 400},
                           { text: 'IE9+', max: 400},
                           { text: 'Safari', max: 400},
                           { text: 'Firefox', max: 400},
                           { text: 'Chrome', max: 400}
                        ]
                    },
                    series : (function (){
                        var series = [];
                        for (var i = 1; i <= 28; i++) {
                            series.push({
                                name:'浏览器（数据纯属虚构）',
                                type: 'radar',
                                symbol: 'none',
                                itemStyle: {
                                    normal: {
                                        lineStyle: {
                                          width:1
                                        }
                                    },
                                    emphasis : {
                                        areaStyle: {color:'rgba(0,250,0,0.3)'}
                                    }
                                },
                                data:[
                                  {
                                    value:[
                                        (40 - i) * 10,
                                        (38 - i) * 4 + 60,
                                        i * 5 + 10,
                                        i * 9,
                                        i * i /2
                                    ],
                                    name:i + 2000
                                  }
                                ]
                            });
                        }
                        return series;
                    })()
                };
                llqzb.setOption(llqzboption);
        </script>
    </div>
</body>
</html>