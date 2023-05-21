import { makeAutoObservable, } from 'mobx'

export default class InfoBarStore {

    audioPush = new Audio(process.env.PUBLIC_URL + '/sounds/hand.mp3');
    audioRound = new Audio(process.env.PUBLIC_URL + '/sounds/tick.mp3');
    audioBid = new Audio(process.env.PUBLIC_URL + '/sounds/bid.mp3');
    audioWinZero = new Audio(process.env.PUBLIC_URL + '/sounds/winzero.mp3');
    audioWin00 = new Audio(process.env.PUBLIC_URL + '/sounds/win0.mp3');
    audioWin01 = new Audio(process.env.PUBLIC_URL + '/sounds/win01.mp3');
    audioWin02 = new Audio(process.env.PUBLIC_URL + '/sounds/win02.mp3');

    constructor() {
        this._clientId = ''
        this._apiKey = ''
        this._start = false
        this._scores = []
        this._winMessadge = ['Крути!', 'Повезет в следующий раз!']
        this._sound = true

        makeAutoObservable(this)
    }

    setClientId(start) {
        this._clientId = start
    }

    getClientId() {
        return this._clientId
    }

    setApiKey(start) {
        this._apiKey = start
    }

    getApiKey() {
        return this._apiKey
    }

    setStart(start) {
        this._start = start
    }

    getStart() {
        return this._start
    }

    setScores(num) {
        this._scores.push(num)
    }

    setClearScores() {
        this._scores = []
    }

    getScores() {
        return this._scores
    }

    setWinMessage(text) {
        this._winMessadge.push(text)
    }

    setClearWinMessage() {
        this._winMessadge = []
    }

    getWinMessage() {
        return this._winMessadge
    }

    setSound(value) {
        this._sound = value
    }

    get sound() {
        return this._sound
    }
}
