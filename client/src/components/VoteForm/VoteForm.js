import { Component } from "react";

class VoteForm extends Component {
    state = { }
    async onSubmit(e) {
        e.preventDefault();
        console.log("Choosen: "+this.state.choosen)
        this.props.vote(this.state.choosen);
    }
    render() { 
        return (
            <div className='vote-form'>
                <form onSubmit={this.onSubmit.bind(this)}>
                    <select onChange={async (e)=>{await new Promise(resolve=>{
                        console.log(e.target.value);
                        this.setState({choosen:parseInt(e.target.value)},()=>{resolve()})})}}>
                        <option>Select Candidate</option>
                        {
                            this.props.candidates.map(can=>(
                                <option value={can.id}>{can.name}</option>
                            ))
                        }
                    </select>
                    <button>Vote</button>
                </form>
            </div>
         );
    }
}
 
export default VoteForm;