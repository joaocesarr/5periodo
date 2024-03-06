import { StyleSheet, Text, View } from 'react-native';
import Imc from './Components/Imc/Imc';
import Like from './Components/Like/Like';

export default function App() {
  return (
    <View style={styles.container}>
      <Imc peso={75.0} altura={1.75} />
      <Imc peso={60.0} altura={1.85} />
      <Like nome="TH"/>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    // flex: 1,
    // backgroundColor: '#666699',
    // alignItems: 'center',
    // justifyContent: 'center',
  }
});
