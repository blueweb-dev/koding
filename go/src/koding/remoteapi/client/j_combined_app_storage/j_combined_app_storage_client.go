package j_combined_app_storage

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"github.com/go-openapi/runtime"

	strfmt "github.com/go-openapi/strfmt"
)

// New creates a new j combined app storage API client.
func New(transport runtime.ClientTransport, formats strfmt.Registry) *Client {
	return &Client{transport: transport, formats: formats}
}

/*
Client for j combined app storage API
*/
type Client struct {
	transport runtime.ClientTransport
	formats   strfmt.Registry
}

/*
PostRemoteAPIJCombinedAppStorageUpsertID post remote API j combined app storage upsert ID API
*/
func (a *Client) PostRemoteAPIJCombinedAppStorageUpsertID(params *PostRemoteAPIJCombinedAppStorageUpsertIDParams) (*PostRemoteAPIJCombinedAppStorageUpsertIDOK, error) {
	// TODO: Validate the params before sending
	if params == nil {
		params = NewPostRemoteAPIJCombinedAppStorageUpsertIDParams()
	}

	result, err := a.transport.Submit(&runtime.ClientOperation{
		ID:                 "PostRemoteAPIJCombinedAppStorageUpsertID",
		Method:             "POST",
		PathPattern:        "/remote.api/JCombinedAppStorage.upsert/{id}",
		ProducesMediaTypes: []string{""},
		ConsumesMediaTypes: []string{"application/json"},
		Schemes:            []string{"http", "https"},
		Params:             params,
		Reader:             &PostRemoteAPIJCombinedAppStorageUpsertIDReader{formats: a.formats},
		Context:            params.Context,
	})
	if err != nil {
		return nil, err
	}
	return result.(*PostRemoteAPIJCombinedAppStorageUpsertIDOK), nil

}

// SetTransport changes the transport on the client
func (a *Client) SetTransport(transport runtime.ClientTransport) {
	a.transport = transport
}