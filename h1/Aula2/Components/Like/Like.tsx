import { useState } from "react";
import { View, Text, Button } from "react-native";

type LikeProps = {
    nome:string
}

const Like = ({nome}:LikeProps) => {

    const[count,setCount] = useState<number>(0) 

    return (        
        <View>
            <Text>Total de Likes do {nome}: {count}</Text>
            <Button title="Like" onPress={() => setCount(count + 1)}/>
        </View>
    );
}

export default Like;