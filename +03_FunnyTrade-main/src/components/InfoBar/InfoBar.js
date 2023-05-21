import { observer } from 'mobx-react-lite';
import React, { useContext, useEffect, useState } from 'react'
import { Context } from '../..';
import randcolor from '../../tools/colorText';
import RandomItem from '../randomItem/RandomItem';
import data from '../../config.json';
import './infoBar.css'

const InfoBar = observer(() => {

    const { user } = useContext(Context)
    const [clientId, setClientId] = useState('');
    const [apiKey, setApiKey] = useState('');
    const [myColor, setMyColor] = useState('white')
    const [errorOrder, setErrorOrder] = useState('')
    const [positions, setPositions] = useState({items: []})

    useEffect(() => {
        if (user.getScores().length === data.length) {

            let arr = JSON.parse(JSON.stringify(user.getScores()))
            console.log(arr);

            let [securityBoard, securityCode] = user.getScores()[0].split(':');
            let quantity = user.getScores()[1]
            let buySell = user.getScores()[2]

            var myHeaders = new Headers();
            myHeaders.append("Content-Type", "application/json-patch+json");
            myHeaders.append("X-Api-Key", apiKey);
            
            var raw = JSON.stringify({
              "clientId": clientId,
              "securityBoard": securityBoard,
              "securityCode": securityCode,
              "buySell": buySell,
              "quantity": quantity,
              "useCredit": false,
              "property": "ImmOrCancel"
            });
            console.log(JSON.stringify(raw))
            
            var requestOptions = {
              method: 'POST',
              headers: myHeaders,
              body: raw
            };
            
            fetch("/api/v1/orders", requestOptions)
              .then(response => response.json())
              .then(result => {
                    console.log("res", result)

                    if(result.error !== null) {
                        if(result.error.data !== null) {
                            setErrorOrder(result.error.message + " " + result.error.data)
                        } else {
                            setErrorOrder(result.error.message)
                        }     
                    } else {
                        setErrorOrder('')
                    }
                    
                    if (user.sound) {
                        if(result.error !== null) {
                            user.audioWin00.play()
                        } else {
                            if(quantity >= 10) {
                                user.audioWin02.play()
                            } else {
                                user.audioWin01.play()
                            } 
                        }       
                    }  
                })
              .catch(error => {
                    console.log("err", error)
                    setErrorOrder(error)

                    if (user.sound) {
                        user.audioWin00.play()
                    }                    
                });

            setTimeout(() => {
                RefreshPositions(apiKey, clientId, setPositions);
            }, 1000);
       
            user.setStart(false)
        }    
    }, [user.getScores().length])

    function settings() {
        user.sound ? user.setSound(false) : user.setSound(true)
    }

    const startStopHandler = () => {
        setMyColor(randcolor())
        user.setClearScores()

        if (user.sound) {
            user.audioPush.play();
        }

        user.setStart(true)
    }

    return (
        <div className='info-bar' >
            <h1 style={{ color: myColor, margin: "5px" }}>One button one trade</h1>

            <div className='myFlex'>
                <div className='myFlexInline'>
                    <p>Client Id</p>
                    <input value={clientId}
                        style={{width: '100px', textAlign: 'left'}}
                        onChange={(event) => {
                            setClientId(event.target.value)
                        }}></input>
                    <p>API Token</p>
                    <input value={apiKey}
                        type={'password'}
                        style={{width: '210px', textAlign: 'left'}}
                        onChange={(event) => {
                            setApiKey(event.target.value)
                        }}></input>
                    <a href='https://docs.comon.ru/trade-api/' target='_blank' rel="noreferrer" style={{ color: 'white' }}>Get Api Token</a>
                </div>

                <div className='settings'>
                    <button className={user.sound ? 'settings-btn sound-on' : 'settings-btn sound-off'}
                        onClick={() => settings()}
                    ></button>
                </div>
            </div>

            <div className='divApp'> 
                {data.map((item) => {
                    return <RandomItem timer={item.Time} arr={item.Arr} speed={2} color={myColor}></RandomItem>
                })}
            </div>

            <div className='info-msg' style={{ height: '30px' }}>
                <p>{errorOrder}</p>
            </div>

            <div className='myFlex btn'>
                {
                    <div className=''>
                        <button disabled={user.getStart()}
                            onClick={() => startStopHandler()}>
                            {user.getStart() ? 'WAIT' : "START"}
                        </button>
                    </div>
                }
            </div>

            <table className='positions-table'>
                <thead>
                <tr>
                    <th style={{ borderColor: myColor }}>Code</th>
                    <th style={{ borderColor: myColor }}>Market</th>
                    <th style={{ borderColor: myColor }}>Balance</th>
                    <th style={{ borderColor: myColor }}>Equity</th>
                    <th style={{ borderColor: myColor }}>Price</th>
                    <th style={{ borderColor: myColor }}>Currency</th>
                    <th style={{ borderColor: myColor }}>MaxBuy</th>
                    <th style={{ borderColor: myColor }}>MaxSell</th>
                    <th style={{ borderColor: myColor }}>Profit</th>
                </tr>
                </thead>
                <tbody>
                {positions.items.map((item) => {
                    return <tr>
                        <td style={{ borderColor: myColor }}>{item.securityCode}</td>
                        <td style={{ borderColor: myColor }}>{item.market}</td>
                        <td style={{ borderColor: myColor }}>{item.balance}</td>
                        <td style={{ borderColor: myColor }}>{item.equity}</td>
                        <td style={{ borderColor: myColor }}>{item.currentPrice}</td>
                        <td style={{ borderColor: myColor }}>{item.currency}</td>
                        <td style={{ borderColor: myColor }}>{item.maxBuy}</td>
                        <td style={{ borderColor: myColor }}>{item.maxSell}</td>
                        <td style={{ borderColor: myColor }}>{item.profit}</td>
                    </tr>
                })}
                </tbody>
            </table>
        </div>
    )
})

export default InfoBar

function RefreshPositions(apiKey, clientId, setPositions) {
    var headers = new Headers();
    headers.append("X-Api-Key", apiKey);

    var options = {
        method: 'GET',
        headers: headers
    };

    fetch("/api/v1/portfolio?ClientId=" + clientId + "&Content.IncludePositions=true&Content.IncludeMaxBuySell=true", options)
        .then(response => response.json())
        .then(result => {
            if (result.error === null) {
                setPositions({ items: result.data.positions });
            } else {
                setPositions({ items: [] });
            }
        })
        .catch(error => console.log('err', error));
}
