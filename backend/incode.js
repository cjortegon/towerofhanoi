exports.get = async (resource, payload, user) => {
    switch(resource) {
        case 'client/incode/hanoi':
            const {disks} = payload
            if(!disks || disks > 10 || disks < 1) return {status: 0, message: 'Disks must be between 1 and 10' }
            const movements = towerOfHanoi(disks, 'A', 'B', 'C')
            console.log("Total movements: "+movements.length)
            return {status: 1, movements}
    }
}

function towerOfHanoi(n, source, auxiliary, target, movements = []) {
    if (n === 1) {
        movements.push({disk: 1, source, target})
        return
    }
    towerOfHanoi(n - 1, source, target, auxiliary, movements)
    movements.push({disk: n, source, target})
    towerOfHanoi(n - 1, auxiliary, source, target, movements)
    return movements
}

// Example usage
// const numDiscs = 3
// const moves = towerOfHanoi(numDiscs, 'A', 'B', 'C')
// console.log(moves)
