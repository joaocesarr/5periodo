import { useEffect, useState } from 'react';
import { StyleSheet, TextInput, View, Text } from 'react-native';
import { Float } from 'react-native/Libraries/Types/CodegenTypes';

type ImcProps = {
    peso:Float,
    altura:Float
}

const Imc = ({peso, altura}:ImcProps) => {
  const[resultado, setResultado] = useState("");
  const[imc, setImc] = useState<Float>(0);

  useEffect(() => {
    setImc( (peso / (altura * altura)) )
  },[2])

  useEffect(() => {
    if(imc == 0 || imc == undefined)
      setResultado("Peso e Altura não informado")
    else if( imc < 18.5 )
      setResultado("Baixo do peso");
    else if ( imc < 25.0 )
      setResultado("Peso adequado");
    else if ( imc < 30.0 )
      setResultado("Sobrepeso");
    else if ( imc < 35.0 )
     setResultado("Obesidade I");
    else if ( imc < 40.0 )
      setResultado("Obesidade II");
    else  if ( imc >= 40.0 && imc != Infinity)
      setResultado("Obesidade III");
    else 
      setResultado("Peso ou Altura não informado");
  },[imc])



//     alert(`IMC: ${imc.toFixed(2)} kg/m² \n${resultado}`)
//    }
  return (
    <View style={styles.container}>      
      <Text style={styles.title}>Seu IMC {imc}</Text> 
      <Text style={styles.title}>Resultado: {resultado}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    // flex: 1,
    // backgroundColor: '#666699',
    // alignItems: 'center',
    // justifyContent: 'center',
  },

  title: {
    fontWeight: '800',
    fontSize: 20,
    marginBottom: 20
  },

  input: {
    // padding: 5,
    // width: '80%',
    // margin: 5,
    // borderRadius: 10,
    // borderWidth: 1,
    // borderColor: 'gray',
    // backgroundColor: '#fff'
  },

  button: {
    // padding: 5,
    // width: '80%',
    // margin: 5,
    // borderRadius: 10,
    // borderWidth: 1,
    // alignItems: 'center',
    // color: '#fff',
    // backgroundColor: '#ff3300',
  }
});

export default Imc;