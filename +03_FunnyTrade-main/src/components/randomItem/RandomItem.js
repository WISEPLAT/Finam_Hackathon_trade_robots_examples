import { observer } from 'mobx-react-lite';
import React, { useContext, useEffect, useState } from 'react';
import { Context } from '../../index';
import { shuffle, getRandomNum } from './random';
import './randomItem.css'

const RandomItem = observer((props) => {
    const { user } = useContext(Context)
    const arrNs = shuffle(props.arr)
    const [currentN, setCurrentN] = useState(arrNs[getRandomNum(0, arrNs.length - 1)])
    const [startAnim, setStartAnim] = useState(user.getStart())
    const [currentAnim, setCurrentAnim] = useState('numInblockStart')

    function rotationSlot(speed) {
        
        setTimeout(() => {
            setStartAnim(true)
            for (let i = 0; i < 10; i++) {
                let index = i % arrNs.length;
                const element = arrNs[index];
                setTimeout(() => {
                    if (i + 1 === 10) {
                        setStartAnim(false)
                        user.setScores(element)
                        setCurrentN(element)
                    } else {
                        setStartAnim(true)
                        setCurrentN(element)
                    }
                }, speed * i)
            }
        }, props.timer);

        return arrNs[arrNs.length - 1];
    }

    useEffect(() => {
        rotationSlot(400)
        user.scores = []
    }, [])

    useEffect(() => {

        if (user.getStart()) {
            setCurrentAnim("numInblock numInblock-anim3")
            rotationSlot(200)
            user.scores = []
        }

    }, [user.getStart()])

    return (
        <div className='num-block' style={{ borderColor: props.color }}  >
            <span className={startAnim ? currentAnim : 'numInblockStart'}>{currentN.split(':').map(str => <p>{str}</p>)}</span>
        </div>
    )
})

export default RandomItem