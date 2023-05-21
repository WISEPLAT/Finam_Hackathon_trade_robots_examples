export default function randcolor() {
    let r = Math.floor(Math.random() * (256))
    let g = Math.floor(Math.random() * (256))
    let b = Math.floor(Math.random() * (256))
    let color = '#' + r.toString(16) + g.toString(16) + b.toString(16);
    return color;
}