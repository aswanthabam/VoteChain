import './Results.css';
import {Component} from 'react';

class Results extends Component {
    state = { }
    
    render() { 
        return (
            <center><div className='result'>
                <table>
                    <tr>
                        <td>Candidate</td>
                        <td>Votes</td>
                    </tr>
                    {
                        this.props.result.map(can => (
                            <tr>
                                <td>{can.name}</td>
                                <td>{can.voteCount}</td>
                            </tr>
                        ))
                    }
                </table>
            </div></center>
        );
    }
}
 
export default Results;