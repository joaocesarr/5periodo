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




  return (
    <View style={styles.container}>      
      <Text style={styles.title}>Seu IMC {imc}</Text> 
      <Text style={styles.title}>Resultado: {resultado}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fffff0',
    alignItems: 'center',
    justifyContent: 'center',
    paddingHorizontal: 20,
  },

  title: {
    fontSize: 36,
    marginBottom: 20,
    textTransform: 'uppercase',
    letterSpacing: 1,
    color: '#FF5733',
    fontFamily: 'Verdana',
    textAlign: 'center',
    fontWeight: 'bold',
    textShadowColor: '#000000', 
    textShadowOffset: { width: 1, height: 1 }, 
    textShadowRadius: 2, 
  
  },

  input: {
    padding: 15,
    width: '90%',
    marginBottom: 20,
    borderRadius: 10,
    borderWidth: 1,
    borderColor: '#FF00FF',
    backgroundColor: '#FFFFFF',
    fontSize: 16,
    color: '#333333',
    textAlign: 'center',
    fontFamily: 'Arial',
  },

  button: {
    paddingVertical: 15,
    paddingHorizontal: 30,
    borderRadius: 8,
    backgroundColor: '#FF00FF',
    alignItems: 'center',
    justifyContent: 'center',
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
    elevation: 5,
  },

  buttonText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontFamily: 'Arial',
    textTransform: 'uppercase',
    fontWeight: 'bold',
  },
  
});

export default Imc;